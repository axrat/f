#!/bin/bash
function arch7(){
mount /dev/sda3 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
mkdir /mnt/home
mount /dev/sda4 /mnt/home
echo "complete"
}
