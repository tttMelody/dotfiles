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
#       CREATED: 01/29/2015 10:44
#      REVISION:  ---
#===============================================================================

if [[ $# -lt 1 ]]; then
	echo "参数错错误"
	exit 1
fi
day=$1
./download_info.sh cn iPhone  $day
./download_info.sh cn iPad  $day
./download_info.sh us iPhone  $day
./download_info.sh us iPad  $day
./download_info.sh jp iPhone  $day
./download_info.sh jp iPad  $day
./download_info.sh tw iPhone  $day
./download_info.sh tw iPad  $day
