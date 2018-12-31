#!/bin/bash
wgetbitbucket(){
  if [ $# -ne 3 ]; then
    echo "Require bitbucket [username],[repouser],[reponame]"
  else
    #--password=password
    wget --user=$1 --ask-password https://bitbucket.org/$2/$3/get/master.zip -O master.zip
  fi
}
