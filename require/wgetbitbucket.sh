#!/bin/bash
wgetbitbucket(){
  if [ $# -ne 3 ]; then
    echo "Require bitbucket [user],[repo],[repo]"
  else
    wget --user=$1 --ask-password https://bitbucket.org/$2/$3/get/master.zip -O master.zip
  fi
}
