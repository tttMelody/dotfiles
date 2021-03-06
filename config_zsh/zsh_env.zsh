export ANDROID_SDK_ROOT="/data/android/android-sdk-macosx/"
export NDK_ROOT="/data/android/android-ndk-r10d"
export ANT_ROOT="/data/android/android-sdk-macosx/platform-tools/"
export COCOS_CONSOLE_ROOT=/data/cocos/tools/cocos2d-console/bin
export COCOS_X_ROOT=/data
export COCOS_TEMPLATES_ROOT=/data/cocos/templates
export GOROOT=/usr/local/go
export GOPATH=$HOME/gocode
export PATH=/usr/local/openresty/nginx/sbin:$PATH
export PATH=$ANDROID_SDK_ROOT/platform-tools:$NDK_ROOT:$ANDROID_SDK_ROOT/tools:$PATH
export PATH=/opt/local/bin:/usr/local/bin:$PATH:/usr/local/bin:/opt/local/bin
export PATH=/opt/local/bin/mongodb/bin:$PATH
export PATH=$COCOS_CONSOLE_ROOT:$PATH
export PATH=/opt/local/lib/mysql55/bin/:$PATH
export PATH=$HOME/bin:$HOME/bin/dmxbin:$PATH
export PATH=/usr/local/go/bin:$PATH
export PATH=$GOROOT/bin:$PATH
export PATH=$GOPATH/bin:$PATH
export PATH=$HOME/.rvm/bin:$PATH # Add RVM to PATH for scripting
export PATH=~/bin:$PATH
export PATH=~/.fzf/bin:$PATH
export PATH=~/.composer/vendor/bin:$PATH
export MANPATH=/opt/local/share/man:$MANPATH
export PAGER="most"

if [[ $DMX_ENV == "home" ]]; then
	export PATH=/usr/local/openresty/bin:$PATH
fi
