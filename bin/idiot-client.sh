#!/bin/bash

LOG_FILE=/tmp/idiot.log

CLIENT_DIR=../arduino
THIS_SCRIPT=$(pwd)/$(dirname $0)/$(basename $0)
LOG=true

PORT1=9090
PORT2=9091

log()
{
    if [ "$LOG" = "true" ]
    then
	echo "[$(date)] $*"
    fi
}

clog()
{
    log " (client) $*"
}



start_client()
{
    cd $CLIENT_DIR
    clog "  start client"
    while (true)
    do
        ./read-and-flash.sh
    done
    cd $CLIENT_DIR
}

stop_client()
{
    clog "Taking down client"

}

if [ "$1" = "--start" ]
then
    start_client
elif [ "$1" = "--stop" ]
then
    stop_client
else
    echo "nothing to do :("
    exit 1
fi
