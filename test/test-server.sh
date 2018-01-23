#!/bin/bash

HOST=localhost
PORT=8080
URL_PATH=lcd
while [ "$1" != "" ]
do
    case "$1" in
        "--host")
            HOST=$2
            shift
            ;;
        "--port")
            PORT=$2
            shift
            ;;
        *)
            echo "SYNTAX ERROR: $1"
            exit 1
            ;;
    esac
    shift
done

test_html_endpoint() {
    w3m -dump http://$HOST:$PORT/$URL_PATH 
}

set_start_value() {
    curl -s http://$HOST:$PORT/$URL_PATH?write=$1 2>/dev/null >/dev/null
}

test_write_endpoint() {
    MSG=$1
    echo -n " * Writing $MSG: "
    curl -s http://$HOST:$PORT/$URL_PATH?write=$MSG 2>/dev/null >/dev/null
    if [ $? -eq 0 ]
    then
        echo "OK"
    else
        echo "FAIL"
    fi

    EXP=$(echo $MSG | sed -e 's,+, ,g' -e 's,",,g')
    echo -n " * Expecting $EXP: "
    GOT=$(curl -s http://$HOST:$PORT/$URL_PATH?format=json | jq '.message' | grep "$EXP" |  sed -e 's,",,g' 2>/dev/null)
    if [ $? -eq 0 ]
    then
        echo "OK"
    else
        echo "FAIL, got $GOT"
    fi

    echo -n " * HTML Expecting $EXP: "
    GOT=$(test_html_endpoint | grep "$EXP" |  sed -e 's,",,g' | wc -l)
    if [ $? -eq 0 ]
    then
        echo "OK"
    else
        echo "FAIL, got \"$GOT\""
    fi
}

test_write_endpoint_fail() {
    MSG=$1
    echo -n " * Writing $MSG: "
    curl -s http://$HOST:$PORT/$URL_PATH?write=$MSG 2>/dev/null >/dev/null
    if [ $? -eq 0 ]
    then
        echo "OK"
    else
        echo "FAIL"
    fi

    EXP=$(echo $MSG | sed -e 's,+, ,g')
    echo -n " * JSON Expecting \"\": "
    GOT=$(curl -s http://$HOST:$PORT/$URL_PATH?format=json | jq '.message' | grep "$EXP" |  sed -e 's,",,g' | wc -l 2>/dev/null)
    if [ $GOT -eq 0 ]
    then
        echo "OK"
    else
        echo "FAIL, got \"$GOT\""
    fi

    echo -n " * HTML Expecting: \"\" "
    GOT=$(test_html_endpoint | grep "$EXP" |  sed -e 's,",,g' | wc -l)
    if [ $GOT -eq 0 ]
    then
        echo "OK ($GOT)"
    else
        echo "FAIL, got \"$GOT\""
    fi
}

test_json_endpoint() {
    curl -s http://$HOST:$PORT/$URL_PATH?format=json | jq '.message'
}




test_json_endpoint

#
# Test good strings
#
for i in "" "a" "Henrik" "Henrik+Rikard+bastards" "Henrik+Rikard+est+los+bastardos"
do
    echo "Test valid input: \"$i\""
    test_write_endpoint $i
done

for i in  "Also+too+looooooong+text+to+fit+on+lcd" 
do
    echo "Testing bad input: \"$i\""
    test_write_endpoint_fail $i
done
