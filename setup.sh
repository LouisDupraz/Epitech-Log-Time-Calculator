#!/bin/sh

USER=$(id -nu 1000)

if [ "$(ls -a /home/$USER/ | grep '.autorun')" == "" ]; then
    mkdir "/home/$USER/.autorun"
fi

if [ "$(ls -a /home/$USER/.autorun/)" == "" ]; then
    cp maintain_active.sh "/home/$USER/.autorun/"
fi

printf "Autorun folder and files created\n"

(crontab -l 2>/dev/null || true; echo "@reboot sh /home/$USER/.autorun/maintain_active.sh") | crontab -

printf "Crontab - Autorun entry created\n"
