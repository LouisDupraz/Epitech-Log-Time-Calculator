#!/bin/sh

USER=$(id -nu 1000)

#echo "Init at $(date)" >> "/home/$USER/.autorun/nw_init.log"

sleep 90

#echo "Started detection at $(date)" >> "/home/$USER/.autorun/nw_init.log"

SSID=$(nmcli -t -f active,ssid dev wifi | egrep '^yes' | cut -d\: -f2)

#echo $SSID >> "/home/$USER/.autorun/nw_init.log"

if [ $SSID == "IONIS" ]; then
    echo "Started activity on $(date)" >> "/home/$USER/.autorun/nw_activity.log"
    tmux new -d "sh /home/$USER/.autorun/loop.sh"
fi

exit 0
