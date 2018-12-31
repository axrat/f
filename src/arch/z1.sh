#!/bin/bash
function arch1(){
if [[ -d "/sys/firmware/efi/efivars" ]] ; then
  echo "EFI MODE"
fi
loadkeys jp106
}
