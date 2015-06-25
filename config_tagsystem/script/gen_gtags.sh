#!/bin/bash - 
#===============================================================================
#
#          FILE: gen_gtags.sh
# 
#         USAGE: ./gen_gtags.sh 
# 
#   DESCRIPTION:  create gtags.files for global tag system
#					need exuberant ctags
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: dingmingxin
#  ORGANIZATION: 
#       CREATED: 06/25/2015 12:46
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

source_root=$(dirname $0)
lua_source_root=$(cd $source_root"/Slua/Resources/" && pwd)
slua_csharp_export_root=$(cd $source_root"/Slua/LuaObject" && pwd)
echo $lua_source_root
echo $slua_csharp_export_root
tagfile=$lua_source_root/GTAGS
filelist=$source_root/.gtags.files

if [[ -f $tagfile ]]; then
	gtags
fi

if [ -f $filelist ]; then
	cat /dev/null > $filelist
else
	touch $filelist
fi

echo 'create gtags.files ... '

update_filelist(){
	find -L -E $lua_source_root -type f \( -iregex ".*/*.txt" -and ! -iregex ".*/.*(tmp|config).*.txt" \) > $filelist
	find -L -E $slua_csharp_export_root -type f \( -iregex ".*/*.cs" \) >> $filelist
}

update_filelist
gtags --gtagsconf /Users/dmx/dotfiles/config_global/gtags.conf --gtagslabel exuberant-ctags -f ./.gtags.files
# gtags --gtagsconf /Users/dmx/dotfiles/config_global/gtags.conf --gtagslabel exuberant-ctags -d GTAGS 

