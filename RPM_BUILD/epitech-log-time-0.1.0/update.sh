#!/bin/sh

USER=$(id -nu 1000)

if [ "$(ls -a /home/$USER/ | grep '.autorun')" == "" ]; then
    echo "Program files not found : please run setup"
    exit 1
fi

cp detect_nw_activity.sh "/home/$USER/.autorun/"
sudo cp log_on_shutdown "/usr/share/"
sudo cp logonstop.service "/usr/lib/systemd/system/"
sudo systemctl daemon-reload

sudo chmod 777 detect_nw_activity.sh
sudo chmod 777 /usr/share/log_on_shutdown

echo "Update complete."
exit 0
