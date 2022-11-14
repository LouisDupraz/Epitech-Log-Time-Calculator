#!/bin/sh
#echo "Init on $(date)" >> /home/LouisD/scripts/nw_init.log
sleep 90

#echo "Started dectection on $(date)" >> /home/LouisD/scripts/nw_init.log
SSID=$(nmcli -t -f active,ssid dev wifi | egrep '^yes' | cut -d\: -f2)

"echo "SSID = $SSID" >> /home/LouisD/scripts/nw_init.log
if [ $SSID == "freebox_moka" ]; then
    echo "Started activity on $(date)" >> "/home/LouisD/scripts/nw_activity.log";
    sh /home/LouisD/scripts/stream.sh
fi

exit 0

