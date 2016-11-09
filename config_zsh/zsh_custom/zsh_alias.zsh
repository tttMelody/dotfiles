#common
alias svnci='svnrmall; svnaddall; svn ci'
alias op='open'
alias rtelnet="rlwrap telnet"

#sanguo2
#alias s2root='cd /data/sanguo2'
#alias s2lua='cd /data/sanguo2/script'
#alias s2pj='cd /data/sanguo2/client'
#alias s2svn='cd /data/sanguo2/svn'
#alias s2ui='cd /data/sanguo2/program/Assets/anim/ui'
#alias s2config='cd /data/sanguo2/program/config'
#alias s2expimage='python /data/sanguo2/client/tool.py tp2 q'
#alias s2expconfig='python /data/sanguo2/client/tool.py cfg q'
#alias s2php='cd /data/www/sanguo2/apps/mingxin'
#alias s2upanim='svn up /data/sanguo2/program/Assets/anim'
#alias s2upconfig='svn up /data/sanguo2/program/config'
#alias s2phpconfig='cd /data/sanguo2/tmp/package/phpconfig/'

#raid
#alias rclient="cd /data/raid/client/"
#alias rlua="cd /data/raid/client/Assets/Slua/Resources"
#alias rserver="cd /data/raid/server"
#alias rconfig="cd /data/raid/client/config"

#ssh
#alias dphoho='ssh deploy@hohoplay.com'

#tetris
#alias tphp="cd /data/www/tetris/apps/mingxin"
#alias tclient="cd /data/tetris/client/"
#alias tlua="cd /data/tetris/script"
#alias tdoc="cd ~/Documents/tetris/Tetris/"
#alias tconfig="cd /data/tetris/res/config"
#alias texpimage="python /data/tetris/dev_tool/tool.py tp2 q"
#alias texpconfig='python /data/tetris/dev_tool/tool.py cfg q'
#alias tdevtool='cd /data/www/tetris/dev_tool'

#match3
#alias mlua="cd /data/match3/client/Assets/Slua/Resources"

#hohoplatform
#alias plua='cd /data/hohoplatform/script'
#alias pclient='cd /data/hohoplatform/client'
#alias pexpimage='python /data/hohoplatform/dev_tool/tool.py tp2 q'
#alias pexpconfig='python /data/hohoplatform/dev_tool/tool.py cfg q'
#alias pdevtool='cd /data/www/hohoplatform/dev_tool'
#alias pandroid='cd /data/hohoplatform/client/proj.android-studio'

#heracles
#alias hdevtool="cd /work/walle_tools && python tool.py && cd -"

alias j=fzf-bookmarks

# === heracles ===
#hash -d hlua="/work/heracles/svn/Resources/script"
#hash -d hclient="/work/heracles"
#hash -d huiflash="/work/heracles/svn/Assets/flahsUITools/assets/ui"
#hash -d hsvn="/work/heracles/svn"
#hash -d hconfigs="/work/heracles/svn/configs"
#hash -d hdmxtool="/work/heracles_tools/"
#hash -d handroid="/work/heracles/frameworks/runtime-src/proj.android"

hash -d myblog=~/Documents/github/dingmingxin.github.io

# === texas ===
DMX_ENV="home"
if [[ $DMX_ENV == "home" ]]; then
	hash -d tlua="/data/staff/texas/client/src/"
	hash -d tskynet="/data/staff/texas/server/"
	hash -d tclient="/data/staff/texas/client"
else
	hash -d tlua="/data/texas/vr-texas/src/"
	hash -d tskynet="/data/texas/vr-texas-server/"
	hash -d tdmxtool="/data/texas/dmxtools/"
	hash -d tnode="/data/texas/vr-texas-server-http/"
	hash -d tart="/data/texas/vr-texas-art/"
fi


#common file type alias
alias -s zip="unzip"
alias -s gz="tar -xzvf"
alias -s tgz="tar -xzvf"
alias -s bz2="tar -xjvf"

