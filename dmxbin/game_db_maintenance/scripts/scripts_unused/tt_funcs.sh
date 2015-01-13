#!/bin/sh

#
# tt_funcs.sh
#
# Developed by Tingkun <tingkun@playcrab.com>
# Copyright (c) 2011 Playcrab Corp.
# Licensed under terms of GNU General Public License.
# All rights reserved.
#
# Changelog:
# 2011-12-22 - created
#


#tcrmgr inform 字段获取

tstatus()
{
    vname=$1
    port=$2
    host=$3
    prog=$4
    [ -n "$host" ]   || host='localhost'
    [ -n "$prog" ]   || prog=$TT_TOOL_TOP/tcrmgr 

    run_status $prog inform -st -port $port   $host | awk '{if($1=="'$vname'"){print $2; exit;} }'
}

db_stop_tokyotyrant() {
  real_stop
}

db_backup_tokyotyrant() {
   dump_ttserver_data $db_port
}

db_start_tokyotyrant() {


	__prestart $folder_name 
    foldername=$WORKDIR/$folder_name

	source $SCRIPT_LIB/common.tokyotyrant
	if [ -f $foldername.conf ] ; then
		source $foldername.conf
	fi 

	if [ -f $foldername/config ] ; then
		source $foldername/config
	fi

    echo "Starting the server of Tokyo Tyrant"

    cmd="$TOKYOTYRANT_SERVER -port $db_port"
    for key in host thnum tout ulim sid mhost mport ; do
        option_name="option_$key"
        if [ -n "${!option_name}" ]; then
            cmd="$cmd -$key ${!option_name}"
        fi
    done
    for key in pid log ulog rts ; do
        option_name="option_$key"
        if [ -n "${!option_name}" ]; then
            cmd="$cmd -$key $foldername/${!option_name}"
            if [[ $key = "ulog" ]]; then
                mkdir -p $foldername/${!option_name}
            fi
        fi
    done

    for key in dmn kl ld le uas rcc ;do
        option_name="option_$key"
        if [[ "${!option_name}" -eq 1 ]]; then
            cmd="$cmd -$key"
        fi
    done
    
    cmd="$cmd $foldername/${db_name}${db_type_and_param}"
    printf "Executing: %s\n" "$cmd"
    $cmd
	__afterstart 

}


#
#將目標ttserver数据按周日期dump，到其对应数据的backup目录
#
# port 
# host
#
dump_ttserver_data()
{
    port=$1
    host=$2
    dir=$3
    sid=$4
    [ -n "$host" ]   || host='localhost'

    need_remote=1
    if [ "$host" == "localhost" ]  || [ "$host" == "127.0.0.1" ] ; then
        need_remote=0
    fi


    loginfo dump start port:$port host:$host
    spath=$(tstatus path $port $host)
    [ ! -f "$spath" ] && { echo $host $port not get db path plz check ; return 1 ; }

    sout_name=$(basename $spath)
    sdata_dir=$(dirname $spath)
    scripts_dir=$(dirname $sdata_dir)

    if [ $need_remote -eq 1 ] ; then
        $CMD_SCP -r $SCRIPT_LIB $host:$scripts_dir/ 
        [ $? -eq 0 ] || { logfatal scripts to $host failed ; return 1 ; }
    fi
	loginfo scripts_dir:$scripts_dir spath:$spath
	$TT_TOOL_TOP/tcrmgr copy -port $port  $host  @$scripts_dir/scripts/tt_run_backup.sh
	[ $? -eq 0 ] || { logfatal dump failed  $TT_TOOL_TOP/tcrmgr copy -port $port $host  @$scripts_dir/scripts/tt_run_backup.sh ; return 1 ; }

	loginfo dump over port:$port host:$host
	#copy out
    if [ -d "$dir" ] ; then 
        mkdir -p $dir/
        if [ $need_remote -eq 1 ] ; then
            $CMD_SCP $host:$sout_path/* $dir/
            [ $? -eq 0 ] || { logfatal  $CMD_SCP failed ; return 1 ; }
        else
            cp -v $sout_path/* $dir/
        fi
    fi
}

#初始化
tt_init(){
            is_slave=0
            cp $SCRIPTDIR/common.tokyotyrant $SCRIPTDIR/$folder_name/config
            if test $# -eq 5;then
                is_slave=1
                master_host=$4
                master_port=$5
                cat >> $SCRIPTDIR/$folder_name/config <<EOF
                option_sid=2
                option_mhost=$master_host
                option_mport=$master_port
EOF
            fi
            if test "$db_type" = "tcb" && test "$is_slave" = "0" 
            then
                echo 'db_type_and_param=".tcb#lmemb=1024#nmemb=2048#bnum=2000000#opts=ld#rcnum=10000000#xmsiz=512M"' >>$SCRIPTDIR/$folder_name/config

            elif test "$db_type" = "tcb" && test "$is_slave" = "1" 
            then
                echo 'db_type_and_param=".tcb#lmemb=1024#nmemb=2048#bnum=2000000#opts=ld#rcnum=10000000#xmsiz=128M"' >>$SCRIPTDIR/$folder_name/config

            elif test "$db_type" = "tch" && test "$is_slave" = "0" 
            then
                echo 'db_type_and_param=".tch#bnum=20000000#rcnum=1000000#xmsiz=256M"' >>$SCRIPTDIR/$folder_name/config
                
            elif test "$db_type" = "tch"&& test "$is_slave" = "1" 
            then
                echo 'db_type_and_param=".tch#bnum=20000000#rcnum=1000000#xmsiz=64M"' >>$SCRIPTDIR/$folder_name/config
            fi
}
