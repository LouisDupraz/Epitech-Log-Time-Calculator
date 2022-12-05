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
            TIMEINIT=$(date +%s)
        fi
    fi
    if [ "$SSID" != "IONIS" ]; then #HERE
        if [ $NWACTIVE -eq 1 ]; then
            echo "End on activity on $(date)" >> "/home/logtime.log"
            NWACTIVE=0
            TIMEEND=$(date +%s)
            PARSEDTIME=(py convert_to_time.py $TIMEINIT $TIMEEND)
            echo "Device was active for $PARSEDTIME" >> "/home/logtime.log"
        fi
    fi
done


exit 0
