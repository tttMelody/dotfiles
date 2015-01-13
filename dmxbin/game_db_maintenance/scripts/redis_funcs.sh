#!/bin/sh

#
# redis_funcs.sh
#
# Developed by Tingkun <tingkun@playcrab.com>
# Copyright (c) 2011 Playcrab Corp.
# Licensed under terms of GNU General Public License.
# All rights reserved.
#
# Changelog:
# 2011-12-22 - created
#
function db_stop_redis() {
   real_stop
}

function db_start_redis() {
    __prestart $folder_name 

    foldername=$WORKDIR/$folder_name
    cp $SCRIPT_LIB/common.redis $WORKDIR/$folder_name/run.conf
    echo "port $db_port" >> $WORKDIR/$folder_name/run.conf

    cd $foldername && $REDIS_SERVER $foldername/run.conf
    sleep 0.1
    if [[ -f "$foldername/pid" ]];then
        loginfo "success start redis server with config $foldername/redis.conf"
        pid=`cat $foldername/pid`
        ps $pid
    else
        loginfo "failed to start redis server with config $foldername/redis.conf"
        tail $foldername/log
    fi
}
