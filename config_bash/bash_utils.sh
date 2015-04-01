#!/bin/bash - 
#===============================================================================
#
#          FILE: bash_utils.sh
# 
#         USAGE: ./bash_utils.sh 
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

# dash search
search_dash()
{
	case $# in
		0) open dash://
			;;
		1) open dash://${1}
			;;
		2) open dash://${1}:${2}
			;;
		*) open dash://
			;;
	esac
}

backup()
{
	if [[ $# -lt 1 ]]; then
		echo "args too less"
		exit
	fi
	cp "$1"{,.bak};
}
