#!/bin/sh



#定义执行程序路径
REDIS_PATHBIN=/usr/
#TT_PATHBIN=/usr/local/
MYSQL_PATHBIN=/usr/
MONGO_PATHBIN=/usr/

CMD_SCP=scp




#大部分情况不需要修改
MONGOD=$MONGO_PATHBIN/bin/mongod
MONGOS=$MONGO_PATHBIN/bin/mongos
REDIS_SERVER=`which redis-server`
#TOKYOTYRANT_SERVER=$TT_PATHBIN/bin/ttserver
#TOKYOTYRANT_SERVER_MANAGER=$TT_PATHBIN/bin/tcrmgr
#TT_TOOL_TOP=$TT_PATHBIN/bin

# 检查数据库程序是否存在
for binary in REDIS_SERVER MONGOS MONGOD
do
    if ! test -x "${!binary}";then
        binary_path=$(which ${!binary})
        if ! test -x "$binary_path";then
            echo "binary[${!binary}] not found"
            exit 1
        fi
        export $binary=$binary_path
    fi
done



[  -f $SCRIPT_LIB/funcs.sh ] || { echo  $SCRIPT_LIB/funcs.sh not  find >&2 ; exit ; }
. $SCRIPT_LIB/funcs.sh
