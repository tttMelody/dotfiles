#!/bin/bash - 
#===============================================================================
#
#          FILE: initwb.sh
# 
#         USAGE: ./initwb.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: dingmingxin, 
#  ORGANIZATION: 
#       CREATED: 10/17/2014 12:21
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error
if [[ ! -d ~/wb ]]; then
	mkdir ~/wb
fi
respositories=( 
	"test" \
	"lua_learn" \
	"cpp_learn" \
	"vimscript_learn" \
	"bash_learn" \
	"python_learn" \
	"algorithm_learn" 
)
for res in ${respositories[@]}
do
	(
		if [[ ! -d ~/wb/${res} ]]; then
			git clone git@bitbucket.org:dingvimer/${res} ~/wb/${res}
		fi
	)
done
