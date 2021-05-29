#!/usr/bin/env bash

installopenrestyubuntu(){

sudo apt-get install -y zlib1g-dev

#https://openresty.org/en/linux-packages.html
sudo apt-get install -y libpcre3-dev \
    libssl-dev perl make build-essential curl
wget -qO - https://openresty.org/package/pubkey.gpg | sudo apt-key add -
sudo apt-get -y install software-properties-common
sudo add-apt-repository -y "deb http://openresty.org/package/ubuntu $(lsb_release -sc) main"
sudo apt-get update
sudo apt-get install openresty

cmdconfirm "sudo ln -s /usr/local/openresty/bin/openresty /usr/bin/openresty"
cmdconfirm "sudo ln -s /usr/local/openresty/nginx /etc/nginx"

echo "complete"
}
