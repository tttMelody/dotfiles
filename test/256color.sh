#!/bin/bash - 
#===============================================================================
#
#          FILE: 256color.sh
# 
#         USAGE: ./256color.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 2014/05/06 22:13
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
256_color2()
{
	for fgbg in 38 48 ; do #Foreground/Background
		for color in {0..256} ; do #Colors
			#Display the color
			echo -en "\033[${fgbg};5;${color}m ${color}\t\033[0m"
			#Display 10 colors per lines
			if [ $((($color + 1) % 10)) == 0 ] ; then
				echo #New line
			fi
		done
		echo #New line
	done
}

256_color1()
{
	echo -en "\n   +  "
	for i in {0..35}; do
		printf "%2b " $i
	done
	printf "\n\n %3b  " 0
	for i in {0..15}; do
		echo -en "\033[48;5;${i}m  \033[m "
	done
	#for i in 16 52 88 124 160 196 232; do
	for i in {0..6}; do
		let "i = i*36 +16"
		printf "\n %3b  " $i
		for j in {0..35}; do
			let "val = i+j"
			echo -en "\033[48;5;${val}m  \033[m "
		done
	done
	echo -e "\n"
}

256_color2
