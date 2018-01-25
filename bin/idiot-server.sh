#!/bin/bash

LOG_FILE=/tmp/idiot.log

SERVER_DIR=/home/hesa/opt/prog-unbook/juneday-infosystem/server/
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

slog()
{
    log " (server) $*"
}



start_server()
{
    cd $SERVER_DIR
    slog "  start server"
    make clean all
    java  -jar winstone.jar:org.json.jar --webroot=www --httpPort=$PORT1 --ajp13Port=$PORT2 &
    JPID=$!
    echo -n "$JPID" > /tmp/idiot.pid
    wait $JPID
}

keep_server()
{
    slog "Gearing up server"

    cd $SERVER_DIR
    while (true)
    do
        $THIS_SCRIPT --single-start
    done
    cd -
}

kill_proc()
{
    SIG=$1
    PID=$2
    if [ "$PID" != "" ]
    then
        kill -$SIG $PID
    fi
}

list_proc()
{
    RE=$1
    ps auxww | \
        grep $RE | \
        grep start |  \
        grep -v grep | \
        grep -v emacs | \
        awk ' { print $2}'
}


stop_server()
{
    slog "Taking down server"

    if [ $(list_proc idiot-server | wc -l) -eq 0 ]
    then
        return
    fi

    slog "  Killing processes:"
    for p in $(list_proc idiot-server)
    do
        slog "    * $p (SIGINT)"
        kill_proc SIGINT "$p"
    done

    for p in $(list_proc idiot-server )
    do
        slog "    * $p (SIGKILL)"
        kill_proc SIGKILL "$p"
    done

    for p in $WIN_PIDS
    do
        echo    kill_proc SIGKILL $p
        ps auxww | grep $p
    done

    echo "Check winstone.... "
    if [ -s /tmp/idiot.pid ]
    then
        echo " * killing java/winstone"
        kill -SIGTERM $(cat /tmp/idiot.pid)
    fi
    echo done
}

if [ "$1" = "--start" ]
then
    keep_server
elif [ "$1" = "--single-start" ]
then
    start_server
elif [ "$1" = "--stop" ]
then
    stop_server
else
    echo "nothing to do :("
    exit 1
fi
