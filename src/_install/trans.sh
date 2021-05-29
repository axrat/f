#!/bin/bash
installtrans(){
#https://github.com/soimort/translate-shell
DIR=/usr/local/bin/
if [ ! -e ${DIR}trans ]; then
  wget git.io/trans
  chmod +x ./trans
  sudo mv ./trans $DIR
fi
}
