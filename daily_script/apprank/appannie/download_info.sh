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
	./download_info.sh cn iPhone 2
ARGS: 
	1. 地区代号:cn us jp tw
	2. 设备:iPhone iPad 
	3. 时间差: 数字（几天之前的排行榜)
Desc:
	生成mongo js 文件,导入数据库方法
	example: 
		mongo localhost:35050 cn_2015-01-27_iPhone_free_js.js
USAGE
}

if [[ $# -lt 3 ]]; then
	echo "参数错误"
	print_usage
	exit 1
fi
DATE=$(which date)
checkDateCommand

# 排行榜所在区域 cn us jp tw 
area_lower=$(echo $1|tr '[:upper:]' '[:lower:]')
area=$(echo $1 |tr '[:lower:]' '[:upper:]')
url_area="china"
case $area in
	"CN")
		url_area="china"
		;;
	"US")
		url_area="united-states"
		;;
	"JP")
		url_area="japan"
		;;
	"TW")
		url_area="taiwan"
		;;
esac
device=$(echo $2|tr '[:upper:]' '[:lower:]')
day_offset=$3
date=$($DATE  -d "$day_offset day ago" "+%Y%m%d")
url_date=$($DATE -d "$day_offset day ago" "+%Y-%m-%d")
case $area in 
	"CN"|"US"|"JP"|"TW")
		;;
	*)
		echo "请输入正确的国家(地区)代号:cn us jp tw"
		exit 1
		;;
esac
genre_id=36
url_1="http://www.appannie.com/apps/ios/top/${url_area}/overall/?device=${device}&date=${url_date}"
url_2="http://www.appannie.com/apps/ios/top-table/${date}-${area}-${genre_id}-${device}/?p=2-&h=11&iap=undefined"
app_url_base="http://www.appannie.com/apps/ios/app"
info_search_url_base="https://itunes.apple.com/lookup?"

pup=$HOME/gocode/bin/pup
rank_html_dir="rank_html"
js_dir="js"
if [[ ! -d $rank_html_dir ]]; then
	mkdir $rank_html_dir
fi
if [[ ! -d $js_dir ]]; then
	mkdir $js_dir
fi
basename=${area_lower}_${date}_${device}
filename="${rank_html_dir}/${basename}.html"


need_download=0
if [[ -f $filename ]]; then
	filesize=$(wc -c $filename |awk '{print $1}')
	if [[ $filesize -lt 1 ]]; then
		need_download=1
	fi
else
	need_download=1
fi
if [[ $need_download -gt 0 ]]; then
	echo -e "1. 下载html:\t\t ${area_lower}_${date}_${device}"
	./curl_html.sh "$url_1" "${filename}"
	./curl_html.sh "$url_2" "${filename}"
else
	echo -e "1. 使用现有html:\t\t ${area_lower}_${date}_${device}"
fi

echo -e "2. 解析html:\t\t ${filename}"
# tidy -im $filename > /dev/null 2>&1  # 整理html代码

rankfilename="${rank_html_dir}/${basename}_rank.txt"
idfilename="${rank_html_dir}/${basename}_id.txt"

cat $filename | $pup 'span[class="oneline-info title-info"] attr{title}' > ${rankfilename}
cat $filename | $pup 'span[style="display:none"] text{}' > ${idfilename}

line=$(wc -l ${rankfilename}|awk '{print $1}')
echo $line
line_arr=$(seq 1 $line)

js_filename="${js_dir}/${basename}_js.js"
if [[ -f $js_filename ]]; then
	rm $js_filename
fi

echo -e "3. 生成mongo文件:\t ${js_filename}"
cat > $js_filename << EOF
var conn = new Mongo("127.0.0.1:35050");
var db = conn.getDB('app_rank');
var dbinstance = db.getSiblingDB('app_rank');
EOF
for i in ${line_arr}
do
	app_id=$(sed -n "${i} p" ${idfilename})
	echo "${basename}_${app_id}_${i}"
	app_image_file="${rank_html_dir}/${app_id}_${area_lower}.txt"
	app_url="${app_url_base}/${app_id}"
	mod=$(( $i%3 ))
	rank_type="free"
	case $mod in
		1) rank_type="free"
			rank=$(( ($i+2)/3 ))
			;;
		2) rank_type="paied"
			rank=$(( ($i+1)/3 ))
			;;
		0) rank_type="bestsell"
			rank=$(( $i/3 ))
			;;
	esac
	info_url="${info_search_url_base}id=${app_id}&country=${area_lower}"
	if [[ -f $app_image_file ]]; then
		app_image=$(sed -n '1p' $app_image_file)
	else
		app_image=$(curl "${info_url}" |jq '.results[0].artworkUrl60'|sed -n "s/\"//g p")
		echo "$app_image" > $app_image_file
	fi
	app_name=$(sed -n "${i} p" ${rankfilename})
	echo "dbinstance.appinfos.insert({" \
		"\"_id\":\"${app_id}_${date}_${device}_${area_lower}_${rank_type}_${genre_id}\"," \
		"\"app_id\":\"${app_id}\"," \
		"\"rank\":\"${rank}\"," \
		"\"app_name\":\"${app_name}\"," \
		"\"area\":\"${area_lower}\"," \
		"\"rank_type\":\"${rank_type}\"," \
		"\"date\":\"${date}\","\
		"\"device\":\"${device}\"," \
		"\"icon\":\"${app_image}\"})" >> $js_filename
done
