#!/bin/bash
gitinitialize(){
  if [ $# -ne 6 ]; then
    echo "Require [host],[user],[repo],[branch],[name],[email]"
  else
    BASE=$(cd $(dirname $0); pwd)
    cd $BASE
    rm -rf .git
    git init
    git remote add origin git@$1:$2/$3.git
    git fetch origin $4 -f
    git reset --hard origin/$4
    git config --local user.name $5
    git config --local user.email $6
    git config --local push.default current
  fi
}
