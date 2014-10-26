#!/bin/bash - 
#===============================================================================
#
#          FILE: test.sh
# 
#         USAGE: ./test.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: dingmingxin (dmx), dignmingxin20@gmail.com
#  ORGANIZATION: 
#       CREATED: 10/26/2014 20:17
#      REVISION:  ---
#===============================================================================

wfg="colour240"
wbg="colour255"
wafg="colour31"

color="#[fg=colour234,bg=colour254]"
promt=""
cur_session_window_num=$(tmux display -p '#{session_windows}')
cur_session_cur_window_index=$(tmux display -p '#I')
if [[ $cur_session_cur_window_index -gt 1 ]]; then
	color="#[fg=,bg=]"
fi
echo $color" #I #W #F⮀"

