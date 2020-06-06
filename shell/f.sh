#!/bin/bash
fupdate(){
  curl https://axrat.github.io/f/f.sh -o f.sh
}
fadd(){
  git add .
}
fcommit(){
  MSG=${@:-"fast commit"}
  git commit --allow-empty -m "$MSG"
  git push --set-upstream origin master
}
facommit(){
  fadd
  fcommit
}
fconfig(){
  git config --local user.name ${1:-"onoie"}
  git config --local user.email ${2:-"onoie3@gmail.com"}
}
fcount(){
  git shortlog -s -n
}
fclone(){
  if [ $# -ne 3 ]; then
    echo "Require[domain],[repouser],[reponame]"
  else
    git clone git@$1:$2/$3.git
  fi
}
fmerge(){
  git merge --allow-unrelated-histories origin/master
}
finitshare(){
  git init --bare --shared
}
fremote(){
  if [ $# -ne 3 ]; then
    echo "Require[domain],[repouser],[reponame]"
  else
    git remote add origin git@$1:$2/$3.git
  fi
}
fresethard(){
  git reset --hard origin/master
}
fresetsoft(){
  git reset --soft HEAD^
}
frelease(){
  if [ $# -ne 1 ]; then
    echo "Require [tag]"
  else
    git tag -d $1
    git push origin :$1
    git commit --allow-empty -m "Release $1"
    git tag $1
    git push --set-upstream origin $1
  fi
}
fpush(){
  git push --set-upstream origin master
}
fpull(){
  git pull --tags
  git pull origin master --depth=1
}
ffetch(){
  git fetch origin
}
frsync(){
  if [ $# -ne 5 ]; then
    echo "Require [port],[from_dir],[to_user],[to_host],[to_dir]"
    echo "e.g. frsync 22 /root/target/ ubuntu aws /home/ubuntu/target/"
  else
    rsync -avh  --exclude='ok' --exclude='.*' \
      -e "ssh -p$1" \
      $2 \
      $3@$4://$5 \
      --bwlimit=1024 #1Mb
  fi
}
fssh(){
  if [ $# -ne 4 ]; then
    echo "Require [user],[host],[port],[identify_file]"
  else
    USER=$1
    HOST=$2
    PORT=$3
    IDENTITY_FILE=$4
    ssh $USER@$HOST -p $PORT -i $IDENTITY_FILE
  fi
}
fless(){
  if [ $# -ne 1 ]; then
    echo "Require [filepath]"
  else
    less $1 | grep -v "^\s*$" | grep -v "^\s*#"
  fi
}


