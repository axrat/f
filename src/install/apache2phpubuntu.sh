#!/bin/bash
installapache2phpubuntu(){
  sudo apt install -y apache2
  sudo a2enmod userdir
  sudo a2enmod include
  sudo a2enmod cgid
  sudo systemctl restart apache2
  sudo apt install -y php
  sudo apt install -y libapache2-mod-php
  sudo mkdir -p /var/www/html
  sudo bash -c "cat << 'EOF' > /var/www/html/info.php
<?php phpinfo();
EOF"
  sudo mkdir -p ~/public_html
  sudo chmod 777 ~/public_html/
  sudo bash -c "cat << 'EOF' > ~/public_html/index.html
HelloWorld
EOF"
}
