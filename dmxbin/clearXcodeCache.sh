#!/bin/bash
cd ~/Library/Application\ Support/iPhone\ Simulator
apps=$(find . -name "*.app")
for app in $apps
do
	configdir=$app"/config"
	if [[ -d $configdir ]]; then
		echo $app
		rm -rf $configdir
		rm -rf $app"/asset"
		rm -rf $app"/script"
	fi
done

cd ~/test
apps=$(find . -name "*.app")
for app in $apps
do
	configdir=$app"/config"
	if [[ -d $configdir ]]; then
		echo $app
		rm -rf $configdir
		rm -rf $app"/asset"
		rm -rf $app"/script"
	fi
done

cd ~/Library/Developer/Xcode/DerivedData/Build/Products/Debug-iphonesimulator/
rm -rf ./*
