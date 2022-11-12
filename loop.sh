#!/bin/sh

while [ true ]; do
    wget http://archlinux.mirrors.ovh.net/archlinux/iso/2022.11.01/archlinux-x86_64.iso
    rm -rf *.iso
done
