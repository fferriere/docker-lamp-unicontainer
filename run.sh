#!/bin/bash

MY_PATH=$(dirname $(realpath $0))
. $MY_PATH"/container-name.conf"

MY_PATH=$(dirname $MY_PATH)

SRC_PATH=$MY_PATH"/src"
LIB_MYSQL_PATH=$MY_PATH"/var_lib_mysql"
LOGS_PATH=$MY_PATH"/logs"

if [ ! -d $LIB_MYSQL_PATH ]; then
    mkdir $LIB_MYSQL_PATH
fi

if [ ! -d $LOGS_PATH ]; then
    mkdir $LOGS_PATH
fi

DOCKER_ARGS='';
PORT_WEB='-p 80:80';
PORT_MYSQL='';

while getopts "mw" OPTION
do
    case "$OPTION" in
    m)
        PORT_MYSQL='-p 3306:3306'
        ;;
    w)
        PORT_WEB=''
        ;;
    esac
    shift
done

PORT_ARGS="$PORT_WEB $PORT_MYSQL"

if [ "$1" = "/bin/bash" ]; then
	DOCKER_ARGS='-t -i';
fi

docker run $DOCKER_ARGS --rm=true $PORT_ARGS \
    -v $LIB_MYSQL_PATH:/var/lib/mysql \
    -v $LOGS_PATH:/var/log/supervisor \
    -v $SRC_PATH:/var/www/ \
    $CONTAINER_NAME $@
