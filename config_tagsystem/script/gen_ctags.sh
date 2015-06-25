#!/bin/sh
page_root=$(dirname $0)
source_top=$(cd $page_root && pwd)
tagfile=$source_top/tags
tagfileList=$source_top/.tagfilelist

if [ ! -f $tagfileList ];
then
    touch $tagfileList
fi
if [[ -f $tagfile ]]; then
	rm $tagfile
fi


echo 'create tags for lua script:'$source_top'........'
updatefile_list(){
   echo "update files  ..."
   find -L $source_top -name  '*.txt' | awk '{
       if(match($0,/unittest\//)==0){
           print
       }
}'  > $tagfileList
}

# 如果要支持emacs 要用 ctags -E 
genluaFileTags() {
	[ "$1" != "" ] && updatefile_list;
	ctags -R -n\
		-f $tagfile \
		-L $tagfileList \
		--tag-relative=yes \
		--langdef=MYLUA \
		--langmap=MYLUA:.txt.cs \
		--regex-MYLUA="/class\((\'|\")([^ ]+)(\'|\")\).*/\2/c/" \
		--regex-MYLUA="/^([^:.= ]+)[ =]+\{\}/\1/c/" \
		--regex-MYLUA="/^[ ]+([a-zA-Z_]+).*/\1/v/" \
		--regex-MYLUA="/^function[ ]+[^:]+:([^ \(]+)/\1/f/" \
		--regex-MYLUA="/^function[ ]+([^:. ]+)\(/\1/f/" \
		--regex-MYLUA="/^function[ ]+[^:]+\.([a-zA-Z_]+)\(/\1/f/" \
		--regex-MYLUA="/^function[ ]+[^:.]+\.class:([a-zA-Z_]+)\(/\1/f/" \
		--regex-MYLUA="/[ ]?local[ ]+function[ ]+([^:.= ]+)\(/\1/f/" \
		--regex-MYLUA="/[ ]?local[ ]+([a-zA-Z_]+)[ ]?=[ ]?function\(/\1/f/" \
		--regex-MYLUA="/([^ ]+)[ ]+=[a-zA-z_ ]+or[ ]+{}/\1/m/" 

}
# 		--regex-MYLUA="/.*subclass\([\'\"]([^ ]+)[\'\"]\)/\1/c/" \
# 		--regex-MYLUA="/local([ ]+)([a-zA-Z_]+)[ ]*=[ ]*oop.class/\2/c/" \

updateCustomCSharpFiles() {
	echo "updateCustomCSharpFiles..."
# 	local luaCSharpPath="${source_top}/../LuaObject"
	local luaCSharpPath="/data/wtcg/client/Assets/Slua/LuaObject"
	echo $luaCSharpPath
	find -L $luaCSharpPath -name  '*.cs' > .tagfilelist
}

genCSharpLuaApiTags() {
	echo "genCSharpLuaApiTags..."
	[ "$1" != "" ] && updateCustomCSharpFiles
	ctags -R -n \
		-f $tagfile \
		-L $tagfileList \
		--append=yes \
		--tag-relative=yes \
		--langdef=MYLUA \
		--langmap=MYLUA:.cs \
		--regex-MYLUA='/addMember\(l,([^ ,_0-9\)\"]+)[_]*/\1/f/' \
		--regex-MYLUA='/addMember\(l,\"([^ ,_0-9\)\"]+)[_]*/\1/f/' \
		--regex-MYLUA='/public class Lua.*_([a-zA-Z]+) :/\1/c/'
		
}

modifyCSharpLuaTags() {
	sed -i "" '/^op_/ d ' $tagfile
}

findLuaClassByFileName() {
	files=$(find . -type f -name "*.txt")
	dir=$source_top
	for filename in ${files[@]}; do
		local f=${filename#.}
		bname=$(basename $filename)
		local str="${bname%.txt}\t${dir}${f}\t1;\"\tc" 
		echo $str >> $tagfile
	done
}

genluaFileTags $@
genCSharpLuaApiTags $@
findLuaClassByFileName
# modifyCSharpLuaTags
# rm $source_top/.tagfilelist

#TODO -- local function
<<desc
c : newClass; subclass
c : 匹配 A={} 类似这种的类定义
m : 匹配新的Model --> 类似于这种：PveModel = PveModel or {}
e : 匹配event和command-->目前只针对于旧代码，evt和command对应的那些
f :
function A:b(..);        --regex-MYLUA="/^function[ ]+[^:]+:([^ \(]+)/\1/f/" \
function aaa(..);        --regex-MYLUA="/^function[ ]+([^:. ]+)\(/\1/f/" \
function A.bb(...);      --regex-MYLUA="/^function[ ]+[^:]+\.([a-zA-Z_]+)\(/\1/f/" \
function A.class:b(..);  --regex-MYLUA="/^function[ ]+[^:.]+\.class:([a-zA-Z_]+)\(/\1/f/" \
local function aa(...);  --regex-MYLUA="/[ ]?local[ ]+function[ ]+([^:.= ]+)\(/\1/f/"
local aa = function(..); --regex-MYLUA="/[ ]?local[ ]+([a-zA-Z_]+)[ ]?=[ ]?function\(/\1/f/"

vim configure:
au FileType lua set tags+=~/.vim/luatags
这样设置的目的是，进入script路径下面的子路径，会找不到tags文件，
从而造成无法跨文件跳转

tags文件用法
1.光标置于方法或者类所在单词上，ctrl-] 跳转到函数或者类的定义处
2.ctrl-t 回到原来的地方

脚本用法: 脚本目录下  "./create_tags.sh ."
2013-10-31 10:54:06
desc
