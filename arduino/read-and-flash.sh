#!/bin/bash

PREV="\"\""
CURR=""
while (true)
do
    TEXT=`curl -s http://localhost:8080/lcd?format=json | jq '.message' | sed -e 's,å,aa,g' -e 's,Å,Aa,g' -e 's,Ä,ae,g' -e 's,Ä,Ae,g'  -e 's,ö,oe,g' -e 's,Ö,Oe,g' ` 
    if [ "$CURR" != "$TEXT" ]
    then
	if [ "$PREV" = "" ]
	then
	    PREV="\"\""
	fi
	
	cat main.c.in | sed -e "s,__LCD_TEXT__,${TEXT},g" -e "s,__LCD_PREV_TEXT__,${PREV},g"  > main.c
	PREV=$CURR
	CURR=$TEXT
	grep scroll main.c
	make upload
    fi
    sleep 10
done


