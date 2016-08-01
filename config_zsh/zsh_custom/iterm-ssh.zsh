tabc() {
	NAME=$1 
	if [[ -z "$NAME" ]]; then 
		NAME="dmx" 
	fi
	echo -e "\033]50;SetProfile=$NAME\a"
}

tab-reset() {
    NAME="dmx"
    echo -e "\033]50;SetProfile=$NAME\a"
}

colorssh() {
	if [[ -n "$ITERM_SESSION_ID" ]]; then
		trap "tab-reset" INT EXIT
		if [[ "$*" =~ ".*localhost*" ]]; then
			echo "haha"
			tabc dmx-remote
		else
			tabc dmx
		fi
	fi
	ssh $@
}

compdef _ssh iterm-tabc=ssh

