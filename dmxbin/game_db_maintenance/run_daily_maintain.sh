#!/bin/bash


page_root=`dirname $0`
my_ab_path=`cd $page_root && pwd`
my_name=`basename $my_ab_path`

#添加需备份的路径到这这下面,crontab 运行

cd $my_ab_path && ./db backup mongo.areslogin.35050
