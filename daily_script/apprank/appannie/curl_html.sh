#!/bin/bash - 
#===============================================================================
#
#          FILE: curl_html.sh
# 
#         USAGE: ./curl_html.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 01/30/2015 15:12
#      REVISION:  ---
#===============================================================================

if [[ $# -lt 1 ]]; then
	echo "参数不不够"
	echo "参数：1. url; 2. filename; "
	exit 1
fi

url=$1
filename=$2

function curl_file
{
	echo $url
curl ${url} \
	-H 'Host: www.appannie.com'  \
	-H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:35.0) Gecko/20100101 Firefox/35.0'  \
	-H 'Accept: */*'  \
	-H 'Accept-Language: zh-cn,en-us;q=0.7,en;q=0.3'  \
	-H 'Cookie: csrftoken=1bef7d794e2a611a2c293d89fe35ee81; __utma=143309285.1426002496.1421637787.1422941358.1422957117.19; __utmz=143309285.1422514797.11.3.utmcsr=192.168.30.168|utmccn=(referral)|utmcmd=referral|utmcct=/xiaosanguo/publish/index.php; __atuvc=21%7C3%2C71%7C4%2C14%7C5; km_ai=dingmingxin%40babeltime.com; km_uq=; km_lv=x; km_ni=dingmingxin%40babeltime.com; __utmv=143309285.|2=UserID=402587=1; sessionId=".eJxNzU1KA0EQhuGxExMdCf6cwYXZDIKewKw06CJY4K6p6S6SJm3N9FS1EkFwJXqG3MhLeBUJRHH38sHD92Ze084ZHAuJhIZb6iSIEusHjLabFcVOpwXsReR5xjk9mKIoHMPIYtaFzUKdDf5mfToo4PBXEWMdyU8N9FGCv4MDbcTm1qOST-YTTv7pGt2S2MP5M9XIGFcanFToXJNZqwkKXbMQS9DwRLeNp3i1FUcYqVPrFuSWVsMjuc3BJsq_SD0oh9-mt38xHl5-uXalL6WF-0mZ-uNZ2n2fpUGufgDTnF4b:1YIa8z:bqKiuNa9Vq93sK79toGQ9c58Kh4"; __utmc=143309285; kvcd=1422958033038; _bizo_bzid=5e857748-2ce9-4673-be24-73f5caae1e00; _bizo_cksm=2B7E155C58A3FC44; _bizo_np_stats=6256%3D376%2C14%3D611%2C; django_language=zh-cn; aa_user_token=".eJxrYKotZNQI5SxNLqmIz0gszihkClVINTBOszA1NbNMSk1JMjcwSjZOMTRNTTNITE1NNUlLMg8Vik8sLcmILy1OLYpPSkzOTs1LKWQONShPTUrMS8ypLMlMLtZLTE7OL80r0XNOLE71zCtOzSvOLMksS_XNT0nNcYLqYQnlRTIpM6WQ1Wu2ChtDqR4ADzw0Lw:1YIW6f:ppQ3UIl5alS-Jcm-RO_xGJrcllU"; __atuvs=54d09a38984a1d9c002; __utmb=143309285.3.10.1422958031969; km_vs=1' \
	-H 'X-NewRelic-ID: VwcPUFJXGwEBUlJSDgc=' \
	-H 'X-Requested-With: XMLHttpRequest' \
	-H 'Connection: keep-alive' >> $filename
}
curl_file
