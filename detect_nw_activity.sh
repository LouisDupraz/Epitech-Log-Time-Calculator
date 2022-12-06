#!/bin/sh

sleep 10

SSID=$(nmcli -t -f active,ssid dev wifi | egrep '^yes' | cut -d\: -f2)
NWACTIVE=0

if [ "$SSID" == "IONIS" ]; then
    echo "Started activity on $(date)" >> "/home/logtime.log";
    NWACTIVE=1
fi

while [ true ]; do
    SSID=$(nmcli -t -f active,ssid dev wifi | egrep '^yes' | cut -d\: -f2)
    if [ "$SSID" = "IONIS" ]; then
        if [ $NWACTIVE -eq 0 ]; then
            echo "Started activity on $(date)" >> "/home/logtime.log";
            NWACTIVE=1
            TIMEINIT=$(date +%s)
        fi
    fi
    if [ "$SSID" != "IONIS" ]; then
        if [ $NWACTIVE -eq 1 ]; then
            echo "End on activity on $(date)" >> "/home/logtime.log"
            NWACTIVE=0
            TIMEEND=$(date +%s)
            DELTATIME=$((TIMEEND - TIMEINIT))
            H=$(echo "scale=0; $DELTATIME/3600 % 24" | bc)
            M=$(echo "scale=0; $DELTATIME/60 % 60" | bc)
            S=$(echo "scale=0; $DELTATIME % 60" | bc)
            echo "Device was active for $H h, $M m, $S s" >> "/home/logtime.log"
        fi
    fi
done

if [ $NWACTIVE -eq 1 ]; then
    echo "End on activity on $(date)" >> "/home/logtime.log"
    NWACTIVE=0
    TIMEEND=$(date +%s)
    DELTATIME=$((TIMEEND - TIMEINIT))
    H=$(echo "scale=0; $DELTATIME/3600 % 24" | bc)
    M=$(echo "scale=0; $DELTATIME/60 % 60" | bc)
    S=$(echo "scale=0; $DELTATIME % 60")
    echo "Device was active for $H h, $M m, $S s" >> "/home/logtime.log"
fi


exit 0
