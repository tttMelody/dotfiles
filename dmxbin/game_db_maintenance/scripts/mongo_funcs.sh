#!/bin/sh

#
# mongo_funcs.sh
#
# Developed by Tingkun <tingkun@playcrab.com>
# Copyright (c) 2011 Playcrab Corp.
# Licensed under terms of GNU General Public License.
# All rights reserved.
#
# Changelog:
# 2011-12-22 - created
#
db_stop_mongos(){
	real_stop
}

db_stop_mongo(){
	real_stop
}

db_start_mongo(){
	__prestart $folder_name
	folder_name=$WORKDIR/$folder_name
	confile=$folder_name.conf
	cat >$confile <<DII
	logpath=$folder_name/log
	dbpath=$folder_name
	port=$db_port
	#unixSocketPrefix
DII
    cat $SCRIPT_LIB/common.mongo >> $confile
	if [ -f $folder_name.conf ] ; then
		cat $folder_name.conf >> $confile
	fi
	pidfile=$folder_name/pid
    cd  $folder_name &&  $MONGOD  -f $confile --pidfilepath $pidfile
}

db_start_mongos(){
	foldername=$WORKDIR/$folder_name
	confile=$folder_name.conf
	cat >$confile <<DII
	logpath=$folder_name/log
	port=$db_port
	pidfilepath=pid
DII
    cat $SCRIPT_LIB/common.mongo >> $confile
    cat $foldername.conf >> $confile
	pidfile=$foldername/pid
    cd $foldername && nohup $MONGOS  -f $confile --pidfilepath $pidfile & #--replSet rs30000/localhost:30001 
}


db_backup_mongo(){
	folder_name=$WORKDIR/$folder_name/dump/$NOW_BACKUP_INDEX
	mkdir -p $folder_name
	echo $TT_NOW_TIMESTAMP > $folder_name/tm 
	date  > $folder_name/../date 
	date  > $folder_name/date 
	$MONGO_PATHBIN/bin/mongodump --port $db_port -o  $folder_name

}

#
# 初始化集群
# $1 db_type,$2 db_name $3 db_port $4 replSet  $5 replHost
# 本机ip从系统获取
#
db_init_mongo(){
	replSet=$4
	if  [ "$replSet" != "" ] ; then
        :



	fi
	
}
