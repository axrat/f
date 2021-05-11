#!/bin/bash
wgetgithub(){
  if [ $# -ne 2 ]; then
    echo "Require bitbucket [user],[repo]"
  else
    wget --no-check-certificate https://github.com/$1/$2/archive/master.zip -O master.zip
  fi
}
