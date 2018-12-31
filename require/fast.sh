#!/bin/bash
fast(){
  if ! type "unzip" > /dev/null 2>&1
  then
    echo "[unzip] Command Not Found"
  else
    if [ $# -ne 2 ]; then
      echo "Require Bitbucket [repouser],[reponame]"
    else
      USERNAME=$1
      REPONAME=$2
      wget --user=$USERNAME --ask-password https://bitbucket.org/$USERNAME/$REPONAME/get/master.zip -O master.zip
      DIRNAME=$(unzip -qql master.zip | head -n1 | tr -s ' ' | cut -d' ' -f5- | rev | cut -c 2- | rev)
      unzip master.zip
      mv $DIRNAME $REPONAME
      rm -f master.zip
    fi
  fi
}

