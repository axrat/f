#!/bin/bash
function arch9(){
loadkeys jp106
pwd
pacman -Syu
pacman -S openssl netctl wireless_tools wpa_supplicant iw wpa_actiond dialog
pacman -S grub
grub-install --recheck /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
echo "complete"
}
