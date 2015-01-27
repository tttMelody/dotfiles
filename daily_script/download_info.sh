#!/bin/bash - 
#===============================================================================
#
#          FILE: download_info.sh
# 
#         USAGE: ./download_info.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 01/20/2015 13:55
#      REVISION:  ---
#===============================================================================

function download_file
{
	curl "$1" -o "$2"
}

today=$(date +%Y-%m-%d)
area=$1 # 排行榜所在区域 cn us jp tw hk
device=$2 # iPhone iPad
channel_name=$3
pop_id=38 #排行榜类型, 畅销 38 ,免费 27 , 付费 30
case $3 in
	"畅销") pop_id=38
		;;
	"免费") pop_id=27
		;;
	"付费") pop_id=30
		;;
	*) pop_id=1
		echo "请输入正确的排行榜名称：畅销、免费、付费"
		exit 1
		;;
esac
genre_id=6014 #应用类别, 6014 是游戏
url="http://www.app12345.com/?area=${area}&store=Apple%20Store&device=${device}&pop_id=${pop_id}&showdate=${today}&showtime=8&genre_id=${genre_id}"
echo $url

pup=/Users/dmx/gocode/bin/pup
basename=${area}_${today}_${device}_${pop_id}
filename=${basename}.html

download_file "$url" "$filename"

sleep 1
# tidy -im $filename > /dev/null 2>&1  # 整理html代码
rankfilename=${basename}_rank.txt
idfilename=${basename}_id.txt
infofilename=${basename}_info.txt
finalinfofile=${basename}_final.txt
cat $filename | $pup 'dl[class="dldefault"] text{}'|sed -n '/[0-9]*\./ s/\./;/ p' > ${rankfilename}
cat $filename | $pup 'a[target="_blank"]' |sed -n -e '/itunes.apple.com/ s/.*id// ' -e 's/\?mt.*// p' > ${idfilename}

line=$(wc -l ${rankfilename}|awk '{print $1}')
line_arr=$(seq 1 $line)

for i in ${line_arr}
do
	info1=$(sed -n "${i} p" ${rankfilename})
	info2=$(sed -n "${i} p" ${idfilename})
	total_info="${info2};${info1};${area};${device};${channel_name};${today}"
	echo $total_info >> ${infofilename}
done

sort -u ${infofilename} > ${finalinfofile}
new_line=$(wc -l ${finalinfofile} |awk '{print $1}')
new_line_arr=$(seq 1 $new_line)

js_filename=${basename}_js.js
cat > $js_filename << EOF
var conn = new Mongo("127.0.0.1:35050");
var db = conn.getDB('app_rank');
var dbinstance = db.getSiblingDB('app_rank');
EOF

MONGO_TABLE_NAME=app_rank
for j in ${new_line_arr}
do
	_id=$(awk -F\; -v lineno=${j} '{if (NR==lineno) print $1}' ${infofilename})
	_rank=$(awk -F\; -v lineno=${j} '{if (NR==lineno) print $2}' ${infofilename})
	_appname=$(awk -F\; -v lineno=${j} '{if (NR==lineno) print $3}' ${infofilename})
	_area=$(awk -F\; -v lineno=${j} '{if (NR==lineno) print $4}' ${infofilename})
	_device=$(awk -F\; -v lineno=${j} '{if (NR==lineno) print $5}' ${infofilename})
	_rank_type=$(awk -F\; -v lineno=${j} '{if (NR==lineno) print $6}' ${infofilename})
	_rank_date=$(awk -F\; -v lineno=${j} '{if (NR==lineno) print $7}' ${infofilename})
	echo "dbinstance.appinfos.insert({" \
		"\"app_id\":\"${_id}\"," \
		"\"rank\":\"${_rank}\"," \
		"\"app_name\":\"${_appname}\"," \
		"\"area\":\"${_area}\"," \
		"\"rank_type\":\"${_rank_type}\"," \
		"\"date\":\"${_rank_date}\","\
		"\"device\":\"${_device}\"})" >> ${js_filename}
done


<<desc
./download_info.sh cn iPhone 畅销
mongo localhost:35050 cn_2015-01-27_iPhone_38_js.js
desc
