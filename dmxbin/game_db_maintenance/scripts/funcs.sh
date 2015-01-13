#!/bin/sh

#
#
# Developed by Tingkun <tingkun@playcrab.com>
# Copyright (c) 2011 Playcrab Corp.
# Licensed under terms of GNU General Public License.
# All rights reserved.
#
# Changelog:
# 2011-12-21 - created
#


WEEK_DAY=$(date +%w)
TIME_NS=$(date +%s%N)
DATE_STR=$(date +%Y%m%d)
TT_NOW_TIMESTAMP=`expr $TIME_NS / 1000`
RUN_DATE=$(date)



TODAY_INDEX=$(($(date +%s)/86400))
BAK_KEEP_NUM=2 #保留最近多少天的备份数据
NOW_BACKUP_INDEX=$(($TODAY_INDEX%$BAK_KEEP_NUM)) 

#命令结果缓存,目前使用5分钟之内结果直接缓存
run_status()
{
    flag=run_status_$(echo $* | sed 's/ //g'  | md5sum | awk '{print $1}')
   # echo $flag $* >&2
    if [ -f /tmp/$flag.out ] ; then
        ltm=$(stat -c %Y /tmp/$flag.out)
        now=$(date +%s)
        #echo cache $flag
        tsdiff=$((now-ltm))

        #5分钟直接返回
        if [  $tsdiff -lt 300 ] ; then
            cat /tmp/$flag.out
            return 0
        fi
    fi
    $*  | tee /tmp/$flag.out 
}



#常用函数 SCRIPTDIR 运行脚本所在目录
#检查配置文件，是否重复运行
__prestart(){
    config_file=$1
    if [[ ! -e "$SCRIPTDIR/$config_file" ]]; then
        echo "config file not exists: $SCRIPTDIR/$config_file"
        exit 1
    fi
    db_type=`echo $config_file | awk -F. '{print $1}'`
    db_name=`echo $config_file | awk -F. '{print $2}'`
    db_port=`echo $config_file | awk -F. '{print $3}'`
    if [[ "$db_type" == ""  ]]  || [[ "$db_port" == ""  ]] || [[ "$db_port" == ""  ]] ; then
        echo "must $db_name $db_type $db_port with  config"
        exit 1
    fi
    local folder_name="$SCRIPTDIR/${db_type}.${db_name}.${db_port}"
    if [[ ! -d "$folder_name" ]]; then
        mkdir -p $folder_name
        if [[ $? -ne 0 ]]; then
            echo "failed to mkdir $folder_name"
            exit 1
        fi
    fi
	local pidfile=$folder_name/config/pid
    if [[ -f $pidfile ]];then
        pid=`cat $pidfile`
        num=`ps $pid | wc -l`
        if [[ $num -gt 1 ]];then
            ps $pid
            echo "$pidfile server is running"
            exit 1
        else
            rm $pidfile 
        fi
    fi

}

#检查是否启动成功
__afterstart(){
    if [ "$?" -eq 0 ] ; then
        printf 'Done\n'
        #return 0
    else
        printf 'The server could not started\n'
        return 1
    fi
	ps aux | grep $port | grep -v grep 
    sleep 0.1
    if [[ -f "$folder_name/config/pid" ]];then
        pid=`cat $folder_name/config/pid`
		if [[ "$pid" == "" ]] ; then
			echo "fail start $db_type server with config $SCRIPTDIR/$config_file"
			return 1
		fi
		echo "success start $db_type server with config $SCRIPTDIR/$config_file"
        ps $pid
		return 0
    else
        echo "failed to start $db_type server with config $SCRIPTDIR/$config_file"
        tail $folder_name/log
    fi
	return 1
}

#停止，传入记录pid文件
#note: 停止后删除pid文件
__pidf_stop() {
    pidfile=$1
    printf 'Stopping the server %s \n' $pidfile
    if [ -f "$pidfile" ] ; then
        pid=`cat "$pidfile"`
		if [ "$pid" == "" ] ; then
            printf 'No process found\n'
			rm -f $pidfile
			return 1
		fi
        num=`ps $pid | wc -l`
        if [[ $num -gt 1 ]];then
            printf "Sending the terminal signal to the process: %s\n" "$pid"
            kill -TERM "$pid"
            c=0
            while true ; do
                sleep 0.1
				num=`ps $pid | wc -l`
                if [[ $num -gt 1  ]] ; then
                    c=`expr $c + 1`
                    if [ "$c" -ge 100 ] ; then
                        printf 'Hanging process: %d\n' "$pid"
                        return 1
                    fi
                else
					rm -f $pidfile
                    printf 'Done\n'
                    return 0
                fi
            done
        else
            printf 'No process found\n'
	    rm -f $pidfile
            return 1
        fi
    else
        printf 'No process found\n'
        return 1
    fi
}


. $SCRIPT_LIB/logconf.sh
. $SCRIPT_LIB/redis_funcs.sh
. $SCRIPT_LIB/mongo_funcs.sh
#. $SCRIPT_LIB/tt_funcs.sh
#. $SCRIPT_LIB/mysql_funcs.sh

