#!/usr/bin/env bash

installopenrestysource(){

#require check package
declare -a PKGS=("libpcre3-dev" "libssl-dev" "perl" "make" "build-essential" "curl")
for ((i = 0; i < ${#PKGS[@]}; i++)) {
  requirepkg ${PKGS[i]}
}

DIRECTORY="openresty-1.13.6.1"
DOWNLOAD="$DIRECTORY.tar.gz"
TO="/usr/local/src"

sudo mkdir -p $TO
##already exist check
if [[ ! -d $TO/$DIRECTORY ]] ; then
  ##check donwload archive
  if [ ! -f "$DOWNLOAD" ] ; then
    wget "https://openresty.org/download/$DOWNLOAD"
  else
    echo "found download:$DOWNLOAD"
  fi
  ##check extract directory
  if [[ ! -d $DIRECTORY ]] ; then
    tar -xvf $DOWNLOAD
  else
    echo "found directory:$DIRECTORY"
  fi
  ##move source directory
  sudo mv $DIRECTORY "$TO/$DIRECTORY"
  rm -f $DOWNLOAD
  rm -rf $DIRECTORY
else
  echo "already exist directory to:$TO/$DIRECTORY"
fi
echo "=> download,extract,move complete"

cd "$TO/$DIRECTORY"
sudo ./configure -j2

cmdconfirm "sudo make -j2"
cmdconfirm "sudo make install"
cmdconfirm "sudo ln -s /usr/local/openresty/bin/openresty /usr/bin/openresty"
cmdconfirm "sudo ln -s /usr/local/openresty/nginx /etc/nginx"

echo "complete"
}
