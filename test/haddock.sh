#!/bin/bash

cat lines.txt | while read line
do
    text=$(echo "$line" | tr ' ' '+')
    wget "http://129.16.213.15:9090/lcd?write=$text" -O res.html &> /dev/null
    sleep $((60*60))
done
