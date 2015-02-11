## PROMPT SETTING START

# 256color

<<desc

echo -e "\033[38;5;208mpeach\033[0;00m"

This will output a pleasing sort of peach colored text.
Taking apart this command: \033[38;5;208m
The \033 is the escape code. The [38; directs command to the foreground. If you want to change the background color instead, use [48; instead. The 5; is just a piece of the sequence that changes color. And the most important part, 208m, selects the actual color.

desc

CC_OFF='\e[0m'       # Text Reset
CURRENT_BG_C="NONE"
CC_FG_PRE="\e[38;5;"
CC_BG_PRE="\e[48;5;"
SEGMENG_SEPRATOR="⮀"
GIT_PS1_SHOWDIRTYSTATE="1"
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
# GIT_PS1_SHOWUPSTREAM="verbose"
fg_color()
{
	color=$1
	echo -n "${CC_FG_PRE}${color}m"
}

bg_color()
{
	color=$1
	echo -n "${CC_BG_PRE}${color}m"
}

parse_git_branch() 
{
	echo -n $(__git_ps1 "(%s)")
}

prompt_segment()
{
	[[ -n $1 ]] && local BG_C=$1 
	[[ -n $2 ]] && local FG_C=$2 
	[[ -n $3 ]] && local TEXT=$3 || local TEXT=""
	if [[ ! $BG_C -eq 256 ]]; then
		local BG=$(bg_color $BG_C)
	fi
	local FG=$(fg_color $FG_C)
	if [[ $CURRENT_BG_C != 'NONE' ]]; then
		local CURRENT_BG=$(fg_color $CURRENT_BG_C)
		echo -n "${BG}${CURRENT_BG}${SEGMENG_SEPRATOR}${FG}"
	else
		echo -n "${BG}${FG}"
	fi
	[[ -n $TEXT ]] && echo -n "${TEXT}"
	echo -n $CC_OFF
	CURRENT_BG_C=$BG_C
}

prompt_simple()
{
	local text_c=$1
	local text=$2
	echo -n $(fg_color $text_c)${text}
	echo -n $CC_OFF
}

prompt_job()
{
	local job=" "
	local stopped=$(jobs -sp | wc -l | tr -d " ")
	local running=$(jobs -rp | wc -l | tr -d " ")
	local bg_c=249
	local fg_c=124
	local total=$((running+stopped))
	if [[ $total -lt 0 || $total -eq 0 ]];then
		return
	fi
	local job="[${running}r/${stopped}s]"
	if [[ -n $1 ]]; then
		prompt_simple $fg_c $job
	else
		prompt_segment $bg_c $fg_c $job
	fi
}

prompt_user()
{
	if [[ -n $1 ]]; then
		prompt_simple 19 "\u@\h:"
	else
		prompt_segment 236 255 "\u@\h" 
	fi
}
prompt_path()
{
	if [[ -n $1 ]]; then
		prompt_simple 39 "\w"
	else
		prompt_segment 239 119 "\w" 
	fi
}
prompt_git()
{
	if [[ -n $1 ]]; then
		prompt_simple 124 $(parse_git_branch)
	else
		prompt_segment  111 124 $(parse_git_branch)
	fi
}

prompt_date()
{
	prompt_segment 123 134 $(date +%T)
}
prompt_end()
{
	if [[ -n $TMUX ]]; then
		local t_p_index=$(tmux display -p '#{pane_index}')
		local tmux_prompt="[$t_p_index]"
	fi
	if [[ -n $1 ]]; then
		local text="\n${tmux_prompt}>"
		echo -n $text
	else
		prompt_segment 256 $CURRENT_BG_C 
		CURRENT_BG_C="NONE"
		echo -n "\n"
		prompt_segment 230 16 "\#"
		prompt_segment 256 $CURRENT_BG_C 
		echo -n $CC_OFF
	fi
}

prompt_begin()
{
	if [[ -n $1 ]]; then
		:
# 		prompt_simple 16 "┌─"
	else
		:
	fi
}


build_prompt()
{
# 	prompt_begin $@
	prompt_job $@
	prompt_user $@
	prompt_path $@
	prompt_git $@
# 	prompt_date $@
	prompt_end $@
}

gen_prompt()
{
	#special code: ┌─└─
# 	local _date_status=$(date "+%F %A %T")
	case "$TERM" in
		xterm-256color)
			export PS1=$(build_prompt 1)
# 			export PS1=$(build_prompt)
			;;
		screen-256color)
             #export PS1="\u@\h:\w\$\n\#>"
			export PS1=$(build_prompt 1)
			;;
		linux)
			export PS1="\u@\h:\w\$\n\#>"
			;;
		*)
			#export PS1="\u@\h:\w\n\$\#>"
			;;
	esac
}

PROMPT_COMMAND=gen_prompt

## PROMPT SETTING END
