#!/bin/sh

sleep 10

USER=$(id -nu 1000)
SSID=$(nmcli -t -f active,ssid dev wifi | egrep '^yes' | cut -d\: -f2)
NWACTIVE=0

if [ "$SSID" == "IONIS" ]; then
    echo "Started activity on $(date)" >> "/home/logtime.log";
    NWACTIVE=1
fi

while [ true ]; do
    sleep 60
    SSID=$(nmcli -t -f active,ssid dev wifi | egrep '^yes' | cut -d\: -f2)
    if [ "$SSID" = "IONIS" ]; then
        if [ $NWACTIVE -eq 0 ]; then
            echo "Started activity on $(date) ($(date +%s))" >> "/home/logtime.log";
            NWACTIVE=1
            echo $(date +%s) > "/home/$USER/.autorun/inittime"
        fi
    fi
    if [ "$SSID" != "IONIS" ]; then
        if [ $NWACTIVE -eq 1 ]; then
            echo "End on activity on $(date) ($(date +%s))" >> "/home/logtime.log"
            NWACTIVE=0
            TIMEINIT=$(cat "/home/$USER/.autorun/inittime" | bc)
            TIMEEND=$(date +%s)
            DELTATIME=$((TIMEEND - TIMEINIT))
            H=$(echo "scale=0; $DELTATIME/3600 % 24" | bc)
            M=$(echo "scale=0; $DELTATIME/60 % 60" | bc)
            S=$(echo "scale=0; $DELTATIME % 60" | bc)
            echo "Device was active for $H h, $M m, $S s ($DELTATIME s)" >> "/home/logtime.log"
            echo "" > "/home/$USER/.autorun/inittime"
        fi
    fi
done

if [ $NWACTIVE -eq 1 ]; then
    echo "End on activity on $(date) ($(date +%s))" >> "/home/logtime.log"
    NWACTIVE=0
    TIMEINIT=$(cat "/home/$USER/.autorun/inittime" | bc)
    TIMEEND=$(date +%s)
    DELTATIME=$((TIMEEND - TIMEINIT))
    H=$(echo "scale=0; $DELTATIME/3600 % 24" | bc)
    M=$(echo "scale=0; $DELTATIME/60 % 60" | bc)
    S=$(echo "scale=0; $DELTATIME % 60")
    echo "Device was active for $H h, $M m, $S s ($DELTATIME s)" >> "/home/logtime.log"
    echo "" > "/home/$USER/.autorun/inittime"
fi


exit 0
