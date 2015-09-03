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

