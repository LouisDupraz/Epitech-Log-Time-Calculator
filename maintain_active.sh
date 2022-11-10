#!/bin/sh

sleep 90

SSID=$(nmcli -t -f active,ssid dev wifi | egrep '^yes' | cut -d\: -f2)

if [ $SSID == "IONIS" ]; then
    echo "Started activity on $(date)" >> "/home/$(id -nu 1000)/.autorun/nw_activity.log"
    tmux new -d 'ping 8.8.8.8'

fi

exit 0
