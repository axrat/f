#!/bin/bash
installvim(){
sudo mkdir -p /usr/local/src
cd /usr/local/src
if [ ! -d /usr/local/src/vim ] ; then
  if [ ! -f /usr/local/src/vim-master.zip ] ; then
    sudo wget --no-check-certificate https://github.com/vim/vim/archive/master.zip -O vim-master.zip
  fi
  sudo unzip vim-master.zip
  sudo mv vim-master vim
else
  echo "found vim directory"
fi
cd vim

sudo ./configure \
 --with-features=huge \
 --enable-multibyte \
 --enable-xim \
 --with-tlib=ncurses \
 --enable-terminal \
 --enable-pythoninterp=dynamic \
 --enable-python3interp=dynamic \
 --enable-fail-if-missing

cd src && sudo make install

echo "complete"
}
