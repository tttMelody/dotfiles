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

day=$1
./download_info.sh cn iPhone 畅销 $day
./download_info.sh cn iPhone 免费 $day
./download_info.sh cn iPhone 付费 $day
./download_info.sh cn iPad 畅销 $day
./download_info.sh cn iPad 免费 $day
./download_info.sh cn iPad 付费 $day
./download_info.sh us iPhone 畅销 $day
./download_info.sh us iPhone 免费 $day
./download_info.sh us iPhone 付费 $day
./download_info.sh us iPad 畅销 $day
./download_info.sh us iPad 免费 $day
./download_info.sh us iPad 付费 $day
./download_info.sh jp iPhone 畅销 $day
./download_info.sh jp iPhone 免费 $day
./download_info.sh jp iPhone 付费 $day
./download_info.sh jp iPad 畅销 $day
./download_info.sh jp iPad 免费 $day
./download_info.sh jp iPad 付费 $day
./download_info.sh tw iPhone 畅销 $day
./download_info.sh tw iPhone 免费 $day
./download_info.sh tw iPhone 付费 $day
./download_info.sh tw iPad 畅销 $day
./download_info.sh tw iPad 免费 $day
./download_info.sh tw iPad 付费 $day
