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

function checkDateCommand
{
	system=$(uname -a|awk '{print $1}')
	if [[ $system == "Darwin" ]]; then
		DATE=/opt/local/bin/gdate
	fi
}

function print_usage
{
	cat <<USAGE
EXAMPLE: 
	./download_info.sh cn iPhone 畅销 2
ARGS: 
	1. 地区代号:cn us jp tw
	2. 设备:iPhone iPad 
	3. 排行榜: 畅销、免费、收费
	4. 时间差: 数字（几天之前的排行榜)
Desc:
	生成mongo js 文件,导入数据库方法
	example: 
		mongo localhost:35050 cn_2015-01-27_iPhone_38_js.js
USAGE
}

function download_file
{
	curl "$1" -o "$2" > /dev/null 2>&1
}
if [[ $# -lt 4 ]]; then
	echo "参数错误"
	print_usage
	exit 1
fi
DATE=$(which date)
checkDateCommand

area=$1 # 排行榜所在区域 cn us jp tw 
device=$2 # iPhone iPad
channel_name=$3
day_offset=$4
date=$($DATE  -d "$day_offset day ago" "+%Y-%m-%d")
pop_id=38 
<<desc
pop_id
iPhone
	畅销：38
	付费: 30
	免费: 27
iPad
	畅销：46
	付费: 47
	免费: 44
desc
case $3 in
	"畅销") 
			pop_id=38
			if [[ $device == "iPad" ]]; then
				pop_id=46
			fi
		;;
	"付费") 
			pop_id=30
			if [[ $device == "iPad" ]]; then
				pop_id=47
			fi
		;;
	"免费") 
			pop_id=27
			if [[ $device == "iPad" ]]; then
				pop_id=44
			fi
		;;
	*) pop_id=1
		echo "请输入正确的排行榜名称：畅销、免费、付费"
		exit 1
		;;
esac
case $area in 
	"cn"|"us"|"jp"|"tw")
		;;
	*)
		echo "请输入正确的国家(地区)代号:cn us jp tw"
		exit 1
		;;
esac
<<desc
genre_id
	36 所有类别，总榜
	6014 游戏总榜
desc
genre_id=36 #应用类别, 6014 是游戏
url="http://www.app12345.com/?area=${area}&store=Apple%20Store&device=${device}&pop_id=${pop_id}&showdate=${date}&showtime=8&genre_id=${genre_id}"

pup=$HOME/gocode/bin/pup
basename=${area}_${date}_${device}_${pop_id}
filename=${basename}.html

echo -e "1. 下载数据:\t\t ${area}_${date}_${device}_$3"
download_file "$url" "$filename"

echo -e "2. 解析html:\t\t ${filename}"
# tidy -im $filename > /dev/null 2>&1  # 整理html代码
rankfilename=${basename}_rank.txt
idfilename=${basename}_id.txt
infofilename=${basename}_info.txt
imgfilename=${basename}_img.txt

cat $filename | $pup 'dl[class="dldefault"] text{}'|sed -n '/[0-9]*\./ s/\./;/ p' > ${rankfilename}
cat $filename | $pup 'a[target="_blank"]' |sed -n -e '/itunes.apple.com/ s/.*id// ' -e 's/\?mt.*// p' > ${idfilename}
cat $filename | $pup 'img[class="img-rounded\ cssshadow"] attr{src}' > ${imgfilename}
if [[ $system == "Darwin" ]]; then
	sed -i '' '1,2 d' ${imgfilename}
else
	sed -i '1,2 d' ${imgfilename}
fi

line=$(wc -l ${rankfilename}|awk '{print $1}')
line_arr=$(seq 1 $line)

js_filename=${basename}_js.js
echo -e "3. 生成mongo文件:\t ${js_filename}"
cat > $js_filename << EOF
var conn = new Mongo("127.0.0.1:35050");
var db = conn.getDB('app_rank');
var dbinstance = db.getSiblingDB('app_rank');
EOF

for i in ${line_arr}
do
	info1=$(sed -n "${i} p" ${rankfilename})
	rank=$(echo $info1|awk -F\; '{print $1}')
	app_name=$(echo $info1|awk -F\; '{print $2}')
	app_name=$(echo $app_name |sed 's/\"//g')
	app_id=$(sed -n "${i} p" ${idfilename})
	image=$(sed -n "${i} p" ${imgfilename})
	echo "dbinstance.appinfos.insert({" \
		"\"_id\":\"${app_id}_${date}_${device}_${area}_${pop_id}_${genre_id}\"," \
		"\"app_id\":\"${app_id}\"," \
		"\"rank\":\"${rank}\"," \
		"\"app_name\":\"${app_name}\"," \
		"\"area\":\"${area}\"," \
		"\"rank_type\":\"${channel_name}\"," \
		"\"date\":\"${date}\","\
		"\"device\":\"${device}\"," \
		"\"icon\":\"${image}\"})" >> ${js_filename}
done
