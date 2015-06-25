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

TAGSYSTEM_ROOT=/Users/dmx/dotfiles/config_tagsystem
GTAGS_CONF_FILE=$TAGSYSTEM_ROOT/gtags.conf
LUA_CTAGS_CONF=$TAGSYSTEM_ROOT/ctags_lua.cnf

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
cp $LUA_CTAGS_CONF ~/.ctags

echo 'create gtags.files ... '

update_filelist(){
	find -L -E $lua_source_root -type f \( -iregex ".*/*.txt" -and ! -iregex ".*/.*(tmp|config).*.txt" \) > $filelist
	find -L -E $slua_csharp_export_root -type f \( -iregex ".*/*.cs" \) >> $filelist
}

update_filelist
gtags --gtagsconf $GTAGS_CONF_FILE --gtagslabel exuberant-ctags -f ./.gtags.files
# gtags --gtagsconf $GTAGS_CONF_FILE --gtagslabel exuberant-ctags -d GTAGS 

