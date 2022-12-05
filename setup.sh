#!/bin/sh

USER=$(id -nu 1000)

if [ "$(ls -a /home/$USER/ | grep '.autorun')" == "" ]; then
    mkdir "/home/$USER/.autorun"
fi

sudo rm -rf '/home/$USER/.autorun/*'

cp detect_nw_activity.sh "/home/$USER/.autorun/"

printf "Autorun folder and files created\n"

(crontab -l 2>/dev/null || true; echo "@reboot sh /home/$USER/.autorun/detect_nw_activity.sh") | crontab -
sudo crontab -n $USER
#sudo systemctl enable cronie ## For non-fedora users (Mainly Arch based)
sudo systemctl enable crond


cd /home/$USER/
sudo chmod 777 .autorun/
cd .autorun/
sudo chmod 777 detect_nw_activity.sh
sudo touch /home/logtime.log
sudo chmod 666 /home/logtime.log
sudo chown $USER /home/logtime.log

printf "Crontab - Autorun entry created\n"

while [ true ]; do
    printf "\nAdd the program to path to be able to run the script from anywhere ?\n"
    read -n 1 k
    if [ $k == "y" ]; then
        echo "PATH=\$PATH:'/home/$USER/.autorun'" >> /home/$USER/.bashrc
        echo "PATH=\$PATH:'/home/$USER/.autorun'" >> /home/$USER/.zshrc
        break
    elif [ $k == "n" ]; then
        break
    fi
done

printf "\n\nSetup complete, script will autorun on boot from now on.\n"
exit 0
