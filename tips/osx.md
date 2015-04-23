##更改默认截图的位图

* defaults write com.apple.screencapture location ~/Pictures/Screenshots

* defaults write com.apple.screencapture type jpg
* -修改默认截图格式
格式支持:
	*	bmp
	*	pdf
	*	jpg
	*	jp2
	*	tif
	*	pict
	*	tga
	*	png
* defaults write com.apple.screencapture name "ScreenShot"
* - 修改默认截图文件前缀
* -重启 uiserver killall SystemUIServer
* defaults write com.apple.screencapture disable-shadow -bool false
* - disable 阴影
