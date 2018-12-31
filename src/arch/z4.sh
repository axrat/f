#!/bin/bash
function arch4(){
dd if=/dev/zero of=/dev/sda bs=512 count=1
sgdisk -Z /dev/sda
echo "complete"
}
