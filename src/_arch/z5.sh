#!/bin/bash
function arch5(){
parted -s -a optimal /dev/sda -- mklabel msdos
#/dev/sda1 boot(1GiB)
parted -s -a optimal /dev/sda -- set 1 boot on
parted -s -a optimal /dev/sda -- mkpart primary ext4 1 1GiB
#/dev/sda2 swap(15GiB)
parted -s -a optimal /dev/sda -- mkpart primary linux-swap 1GiB 16GiB
#/dev/sda3 root(32GiB)
parted -s -a optimal /dev/sda -- mkpart primary ext4 16GiB 48GiB
#/dev/sda4 home
parted -s -a optimal /dev/sda -- mkpart primary ext4 48GiB 100%
#parted -l -m
fdisk -l
#parted -s -a optimal /dev/sda -- mklabel mkpard primary ext4 1 -1 set 1 lvm on
echo "complete"
}
