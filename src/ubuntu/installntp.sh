#!/bin/bash
ubuntuinstallntp(){
  sudo apt-get install ntp
  sudo /etc/init.d/ntp start
}
