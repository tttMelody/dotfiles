export FZF_DEFAULT_OPTS='
--extended
--bind ctrl-f:page-down,ctrl-b:page-up
--color fg:252,bg:233,hl:220,fg+:252,bg+:235,hl+:226
--color info:144,prompt:161,spinner:135,pointer:135,marker:118
'

# for tmux select-pane
ftpane () {
	local panes current_window target target_window target_pane
	panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
	current_window=$(tmux display-message  -p '#I')

	target=$(echo "$panes" | fzf) || return

	target_window=$(echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
	target_pane=$(echo $target | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

	if [[ $current_window -eq $target_window ]]; then
		tmux select-pane -t ${target_window}.${target_pane}
	else
		tmux select-pane -t ${target_window}.${target_pane} &&
			tmux select-window -t $target_window
	fi
}

#for tmux select session
fs() {
	local session
	session=$(tmux list-sessions -F "#{session_name}" | \
		fzf --query="$1" --select-1 --exit-0) &&
		tmux switch-client -t "$session"
}
#change directory
fd() {
	local dir
	dir=$(find ${1:-*} -path '*/\.*' -prune \
		-o -type d -print 2> /dev/null | fzf +m) &&
		cd "$dir"
}

#change directory including hidden directory
fda() {
	local dir
	dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}

# cdf - cd into the directory of the selected file
cdf() {
	local file
	local dir
	file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}

fh() {
	eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

cho() {
	local cols sep
	cols=$(( COLUMNS / 3 ))
	sep='{{::}}'

	# Copy History DB to circumvent the lock
	#   # - See http://stackoverflow.com/questions/8936878 for the file path
	cp -f ~/Library/Application\ Support/Google/Chrome/Default/History /tmp/h

	sqlite3 -separator $sep /tmp/h \
		"select substr(title, 1, $cols), url
	from urls order by last_visit_time desc" |
	awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\n", $1, $2}' |
	fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs open
}

# fzf quickly access to emacs buffer
febf() 
{
	#NOTICE: emacs must work in daemon mode
	local EMACSCLIENT=$(which emacsclient)
	buffers=$($EMACSCLIENT -e "(mapcar #'(lambda(x) (buffer-name x)) (buffer-list))")
	local SYSTEM_TYPE=$(uname -a | awk '{print $1}')
	local sed_regex_opt="-E"
	if [[ $SYSTEM_TYPE == Linux ]]; then
		sed_regex_opt="-r"
	fi

	buffers=$(echo $buffers |sed $sed_regex_opt -e "s/\(//g" \
		-e "s/\)//g" \
		-e "s/\" \"/,/g" \
		-e "s/\"//g" \
		-e "s/[\ ]?\*([^,])*\*[-_a-zA-Z0-9]*[,]?//g" \
		-e "s/[^,]*mode,//g" \
		-e "s/,$//g")

	bname_arra=()
	if [[ $SHELL == *zsh ]]; then
		IFS=', ' read -A bname_arr <<< "$buffers"
	elif [[ $SHELL == *bash ]]; then
		IFS=', ' read -a bname_arr <<< "$buffers"
	fi

	target_buffer_info=$(for b in ${bname_arr[@]}
	do
		bfilename=$(emacsclient -e "(with-current-buffer \"${b}\" (buffer-file-name))")
		if [[ $bfilename != nil ]] then
			info=$(printf "%-30s  %s" ${b} ${bfilename})
			echo $info
		fi
	done| fzf-tmux --query="$1" --select-1) && \
		target_buffer=$(echo $target_buffer_info |awk '{print $1}') && \
		$EMACSCLIENT -t -e "(switch-to-buffer \"${target_buffer}\")"
}


