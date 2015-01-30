#!/bin/bash - 
#===============================================================================
#
#          FILE: download_all.sh
# 
#         USAGE: ./download_all.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 01/29/2015 11:36
#      REVISION:  ---
#===============================================================================

arr=$(seq 0 84)
for day in ${arr}
do
	(
	./download_all_oneday.sh $day
	)
done
