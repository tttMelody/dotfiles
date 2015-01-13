#!/bin/sh

#
# mysql_funcs.sh
#
# Developed by Tingkun <tingkun@playcrab.com>
# Copyright (c) 2011 Playcrab Corp.
# Licensed under terms of GNU General Public License.
# All rights reserved.
#
# Changelog:
# 2011-12-22 - created
#


db_start_mysql(){
   cd $folder_name  && ./ctrl start
}

db_stop_mysql(){
   cd $folder_name  && ./ctrl stop
}

init_mysql(){
name=$1
port=$2

WORKDIR=$SCRIPTDIR

mysql_user='root'
mysql_password=''



basedir=$WORKDIR/mysql.$name.$port

mport=$((port+1))
if [ $mport -eq 1 ] ;then
	echo 'port invalid,use default 3306'
	port=3306
fi

mdata_dir=$basedir/data
if [ -d $mdata_dir ] ; then 
	echo "data dir :$mdata_dir exists .exit";
	return 1
fi

echo init mysql db in $mdata_dir
mrun_dir=$basedir/
mlog_dir=$basedir/log
mkdir -p $mrun_dir
mkdir -p $mlog_dir
mkdir -p $mdata_dir/binlog

sockfile=$basedir/sock.$port

CONFFILE=$SCRIPTDIR/mysql.$name.$port.conf

cat >$CONFFILE <<EOT
[mysqld]

#basedir = $MySQL
skip-name-resolve
# generic configuration options
port		= $port
socket		= $sockfile
log-error = $mrun_dir/error.log
default-character-set = utf8
datadir = $mdata_dir

back_log = 50
long_query_time = 1
log_long_format
log-slow-queries=$mrun_dir/slow.sql
EOT



#control script
cat > $mrun_dir/ctrl <<EOT
#!/bin/sh
mysql_port=$port
mysql_username=$mysql_user
mysql_password="$mysql_password"

function_start_mysql()
{
	printf "Starting MySQL...\n"
	$MYSQL_PATHBIN/bin/mysqld_safe --defaults-file=$CONFFILE 2>&1 > /dev/null &
}

function_stop_mysql()
{
    printf "Stoping MySQL...\n"
    $MYSQL_PATHBIN/bin/mysqladmin -u ${mysql_user} -uroot -S $sockfile shutdown
}


function_restart_mysql()
{
	printf "Restarting MySQL...\n"
	function_stop_mysql
	sleep 5
	function_start_mysql
}


function_kill_mysql()
{
	kill -9 \$(ps -ef | grep 'bin/mysqld_safe' | grep ${port} | awk '{printf \$2}')
	kill -9 \$(ps -ef | grep 'libexec/mysqld' | grep ${port} | awk '{printf \$2}')
}


if [ "\$1" = "start" ]; then
	function_start_mysql
elif [ "\$1" = "stop" ]; then
	function_stop_mysql
elif [ "\$1" = "restart" ]; then
	function_restart_mysql
elif [ "\$1" = "kill" ]; then
	function_kill_mysql
else
	printf "Usage: $mrun_dir/ctrl {start|stop|restart|kill}\n"
fi

EOT
chmod +x $mrun_dir/ctrl

cat >$mrun_dir/cli <<EOT
$MYSQL_PATHBIN/bin/mysql -uroot  -S $sockfile
EOT
chmod +x $mrun_dir/cli

#chown -R mysql:mysql $DATA/mysql
$MYSQL_PATHBIN/bin/mysql_install_db --basedir=$MYSQL_PATHBIN \
--datadir=$mdata_dir --user=$USER \
--defaults-file=$CONFFILE 
cat <<EOT
$MYSQL_PATHBIN/bin/mysql -uroot -P$port 
GRANT ALL PRIVILEGES ON *.* TO '$mysql_user'@'localhost' IDENTIFIED BY '$mysql_password';
GRANT ALL PRIVILEGES ON *.* TO '$mysql_user'@'127.0.0.1' IDENTIFIED BY '$mysql_password';
EOT


}

