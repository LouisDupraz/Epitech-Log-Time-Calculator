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

while [ true ]; do
    printf "\nAdd the program to path to be able to run the script from anywhere ?\n"
    read -n 1 k
    if [ $k == "y" ]; then
        echo "\nPATH=\$PATH:'/home/$USER/.autorun'" >> /home/$USER/.bashrc
        echo "\nPATH=\$PATH:'/home/$USER/.autorun'" >> /home/$USER/.zshrc
        break
    elif [ $k == "n" ]; then
        break
    fi
done

printf "\n\nSetup complete, script will autorun on boot from now on.\n"
exit 0
