#!/bin/sh

ARCHVERSION=$(curl https://archlinux.org/download/ | grep "<li><strong>Current Release:</strong> " | cut -d\> -f4 | cut -d\< -f1 | tr -d ' ')

while [ true ]; do
    wget http://archlinux.mirrors.ovh.net/archlinux/iso/$ARCHVERSION/archlinux-x86_64.iso
    rm -rf *.iso
done
