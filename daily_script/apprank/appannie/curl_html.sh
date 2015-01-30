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
	-H 'Accept-Language: zh-cn,en-us;q=0.7,en;q=0.3'  \
	-H 'Cookie: csrftoken=1bef7d794e2a611a2c293d89fe35ee81; __utma=143309285.1426002496.1421637787.1422602277.1422610013.16; __utmz=143309285.1422514797.11.3.utmcsr=192.168.30.168|utmccn=(referral)|utmcmd=referral|utmcct=/xiaosanguo/publish/index.php; __atuvc=21%7C3%2C67%7C4; km_ai=dingmingxin%40babeltime.com; km_uq=; km_lv=x; dashboard_page_interval=50; km_ni=dingmingxin%40babeltime.com; __utmv=143309285.|2=UserID=402587=1; sessionId=".eJxNzc1KQzEQhuE01iqR-ncBrlzo5uBO13alRRfFAXdhTjK0oTHn5MxEaaHgSqi34MV5K1Ko4u7lg4fvXa9y7wJOmJhDk1rqOLBQkjUMt5tlwU7GCvYjpmnBKT1rpZRLMLRYZGYLU2eDv_86Hyg4-lWUsI7kxxr6yME_woE0bEvrUchnvYbTf7pGN6fk4eqNakwYFxIcV-hcU5JUI2S6S0yJg4RXemg8xdutOMZInVg3Ize3El7IbQ42Yf4i74DZ--6dGX19ePPp2oUsjYWnkcn9y0ne_ZjkQal-AM7tXd8:1YH8Pg:TBcHQLbJcQR_XS_5YXCIvo5Zg2E"; django_language=zh-cn; __utmb=143309285.9.10.1422612971844; __utmc=143309285; kvcd=1422612974298; km_vs=1; __atuvs=54cb4e6a0183f1d3006; aa_user_token=".eJxrYKotZNQI5SxNLqmIz0gszihkClVINTBOszA1NbNMSk1JMjcwSjZOMTRNTTNITE1NNUlLMg8Vik8sLcmILy1OLYpPSkzOTs1LKWQONShPTUrMS8ypLMlMLtZLTE7OL80r0XNOLE71zCtOzSvOLMksS_XNT0nNcYLqYQnlRTIpM6WQ1Wu2ChtDqR4ADzw0Lw:1YH8Pg:gApsAkdBwqFLpS7Gjuj1rmp8Bek"'  \
	-H 'Host: www.appannie.com'  \
	-H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:35.0) Gecko/20100101 Firefox/35.0'  \
	-H 'X-NewRelic-ID: VwcPUFJXGwEBUlJSDgc='  \
	-H 'X-Requested-With: XMLHttpRequest' >> $filename
}
curl_file
