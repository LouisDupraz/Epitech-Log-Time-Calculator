#!/bin/sh

SSID=$(nmcli -t -f active,ssid dev wifi | egrep '^yes' | cut -d\: -f2)
NWACTIVE=0

if [ "$SSID" == "IONIS" ]; then
    echo "Started activity on $(date)" >> "/home/logtime.log";
    NWACTIVE=1
fi

while [ true ]; do
    SSID=$(nmcli -t -f active,ssid dev wifi | egrep '^yes' | cut -d\: -f2)
    if [ "$SSID" = "IONIS" ]; then #HERE
        if [ $NWACTIVE -eq 0 ]; then
            echo "Started activity on $(date)" >> "/home/logtime.log";
            NWACTIVE=1
        fi
    fi
    if [ "$SSID" != "IONIS" ]; then #HERE
        if [ $NWACTIVE -eq 1 ]; then
            echo "End on activity on $(date)" >> "/home/logtime.log"
            NWACTIVE=0
        fi
    fi
done


exit 0
