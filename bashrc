#!/bin/bash
# .bashrc

# Source global definitions

export COCOS_CONSOLE_ROOT=/data/cocos/tools/cocos2d-console/bin
export PATH=${PATH}:/usr/local/bin:/opt/local/bin:/opt/local/sbin
export PATH=${PATH}:$HOME/bin:$HOME/bin/dmxbin
export PATH=${PATH}:/data/sanguo/android-sdk-macosx/platform-tools
export PATH=${PATH}:/data/sanguo/android-sdk-macosx/tools
export PATH=${PATH}:/data/sanguo/android-ndk-r8e

export PATH=$COCOS_CONSOLE_ROOT:$PATH


# Finished adapting your PATH environment variable for use with MacPorts.


# Add environment variable COCOS_CONSOLE_ROOT for cocos2d-x

if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
	   . /opt/local/etc/profile.d/bash_completion.sh
fi

if [ -f ~/git-completion.bash ]; then
  . ~/git-completion.bash
fi

#share command history with different bash ttys
export HISTCONTROL=ignoredups
export HISTIGNORE="[   ]*:&:bg:fg:exit"
export HISTFILESIZE=1000000000
export HISTSIZE=1000000
shopt -s histappend
if [ -f ~/.bash_prompt ]; then
	. ~/.bash_prompt
fi

export GIT_SSL_NO_VERIFY=true

export DISPLAY=:0
###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
export COMP_WORDBREAKS

if complete &>/dev/null; then
  _npm_completion () {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           npm completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -F _npm_completion npm
elif compctl &>/dev/null; then
  _npm_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       npm completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _npm_completion npm
fi
###-end-npm-completion-###

export EDITOR=vim
export HISTSIZE=1000000
export HISTFILESIZE=1000000
shopt -s histappend

#set ls command color
export CLICOLOR="xterm-color"
# export LSCOLORS=Ehfxcxdxbxegedabagacad
export LSCOLORS=ExFxCxDxbxegedabagacad

export GREP_OPTIONS="--color=auto"
if [ -f ~/.bash_aliases ]; then
	source ~/.bash_aliases
fi
