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
	-H 'Accept: */*'  \
	-H 'Accept-Language: zh-CN,zh;q=0.8,en-US;q=0.5,en;q=0.3'  \
	-H 'Connection: keep-alive'  \
	-H 'Cookie: csrftoken=f7cf511bc3daf78c5ba3c57abd5f966c; __atuvc=0%7C12%2C0%7C13%2C0%7C14%2C0%7C15%2C5%7C16; __utma=143309285.2391747.1425275904.1425544491.1429780421.3; __utmz=143309285.1425544491.2.2.utmcsr=apprank.hohoplay.com|utmccn=(referral)|utmcmd=referral|utmcct=/index.php; km_ai=1029217068%40qq.com; km_uq=; km_lv=x; sessionId=".eJxNzU1KA0EQhuG2HR0dGfzZeAXdDG7dmpUGXUQL3DU13UXSpO2ZnqpWIgSyEj2SJ_AYXkUCUdy9fPDwrfQybZ3BMROz72JPA3sWivIO9WYzLDjIWMFewDjNOKVHrZSyMWmoDWaZmcw0GO9uvopSweGvo4htIDfWUCB7dwcH0rHJvUMhl7Y_4OSfbtHOKTq4eKEWI4aFeMsNWtvlKM0Ima4jU2Qv_pluO0fhaiOOMNAgxs7Izo34J7Lrg3VUf5EKqMrv4nS_vtSf97ZfyGtl4GFUpZ3zSdp9m6QyNz9m516p:1YlDCn:ty9QyYe5u4e4Fj4cgmCD8ZDUc00"; aa_language=cn; django_language=zh-cn; __utmb=143309285.11.10.1429782177334; __utmc=143309285; kvcd=1429782176406; km_vs=1; _bizo_bzid=4ba9fe8a-9525-4dc0-98dd-e734888f454e; _bizo_cksm=9BB3C16331A1878C; _bizo_np_stats=6256%3D258%2C14%3D640%2C; aa_user_token=".eJxrYKotZNQI5SxNLqmIz0gszihkClVINTBOszA1NbNMSk1JMjcwSjZOMTRNTTNITE1NNUlLMg8Vik8sLcmILy1OLYpPSkzOTs1LKWQONShPTUrMS8ypLMlMLtZLTE7OL80r0XNOLE71zCtOzSvOLMksS_XNT0nNcYLqYQnlRTIpM6WQ1es4CztDqR4AD6g0PA:1YlDCm:ceRhzALUXNakrVZxXZj0VppOibE"; __utmv=143309285.|2=UserID=459975=1^3=Account%20Type=Internet%20Firms=1^4=Account%20Type=150%20to%20499%20employees=1; km_ni=1029217068%40qq.com; X-Mapping-fjhppofk=73E7B97E05DF7476CDEA44D9A1D1487F; _ga=GA1.2.2391747.1425275904; _mkto_trk=id:071-QED-284&token:_mch-appannie.com-1429780451821-17087; __atuvs=5538b7ea2549baa6004'  \
	-H 'Host: www.appannie.com'  \
	-H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:36.0) Gecko/20100101 Firefox/36.0'  \
	-H 'X-NewRelic-ID: VwcPUFJXGwEBUlJSDgc='  \
	-H 'X-Requested-With: XMLHttpRequest' >> $filename
}
curl_file
