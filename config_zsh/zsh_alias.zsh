#!/bin/bash - 
#===============================================================================
#
#          FILE: zsh_alias.sh
# 
#         USAGE: ./zsh_alias.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: dingmingxin
#  ORGANIZATION: 
#       CREATED: 03/31/2015 23:57
#      REVISION:  ---
#===============================================================================
unamestr=$(uname)
platform="unknown"

alias svnci='svnrmall; svnaddall; svn ci'
alias la="ls -lhGa"
alias ll='ls -dlh ^*.(meta|csproj|userprefs|sln|unityproj|csproj)'
alias ld='ls -lhG -d *(/)'
alias op='open'
alias bs='source ~/.bash_profile'
alias e="emacsclient -t -a ''"
alias ek="emacsclient -e '(kill-emacs)'"
alias gpp="git pull && git push"
alias gpl="git pull"
alias gph="git push"

if [[ $unamestr == "Darwin" ]]; then
	platform="osx"
elif [[ $unamestr == "Linux" ]]; then
	platform="linux"
fi

if [[ $platform == "osx" ]]; then
	alias ds='search_dash'
fi
