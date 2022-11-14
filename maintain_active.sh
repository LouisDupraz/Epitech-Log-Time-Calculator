#!/bin/sh

sleep 90

SSID=$(nmcli -t -f active,ssid dev wifi | egrep '^yes' | cut -d\: -f2)

if [ $SSID == "IONIS" ]; then
    echo "Started activity on $(date)" >> "/home/LouisD/scripts/nw_activity.log";
    sh /home/LouisD/scripts/stream.sh
fi

exit 0

