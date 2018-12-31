#!/bin/bash
gitinitialize(){
  if [ $# -ne 3 ]; then
    echo "Require [host],[user],[repo]"
  else
    rm -rf .git
    git init
    git remote add origin git@$1:$2/$3.git
    git fetch origin -f
    git reset --hard origin/master
  fi
}
