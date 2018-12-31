#!/bin/bash
installdein(){
  if [ -d ~/.vim/dein/repos/github.com/Shougo/dein.vim ]; then 
    echo "found dein directory"
  else 
    DOWNLOAD=installer.sh 
    curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > $DOWNLOAD 
    chmod +x $DOWNLOAD 
    sh ./$DOWNLOAD ~/.vim/dein 
    rm $DOWNLOAD 
  fi
}
