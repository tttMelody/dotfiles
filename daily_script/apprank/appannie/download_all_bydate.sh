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

DATE=$(which date)
system=$(uname -a|awk '{print $1}')
if [[ $system == "Darwin" ]]; then
	DATE=/opt/local/bin/gdate
fi

function print_usage
{
	cat <<USAGE
EXAMPLE: 
	./download_all_bydate.sh 2015-01-29
USAGE
}
if [[ $# -lt 1 ]]; then
	print_usage
	exit 1
fi

destday=$1
dest_stamp=$($DATE -d "$destday" "+%s")
if [[ $? -gt 0 ]]; then
	echo '日期不合法'
	exit 1
fi

today=$($DATE "+%Y-%m-%d")
today_stamp=$($DATE -d "$today" "+%s")
if [[ $dest_stamp -gt $today_stamp ]]; then
	echo "日期不能比今天晚"
	exit 1
fi
delta=$(( $today_stamp - $dest_stamp ))
offset=$(( $delta / 86400 ))
./download_all_oneday.sh $offset
