#!/bin/bash
dockerexec(){
sudo docker exec -it $1 /bin/bash
}
dockerrminone(){
sudo docker images | awk '/<none/{print $3}' | xargs sudo docker rmi
}
dockerstopall(){
sudo docker stop $(sudo docker ps -a -q)
}
dockerrmall(){
sudo docker rm $(sudo docker ps -a -q)
}
dockerstartonwslforadmin(){
#sudo apt-get install -y docker.io
sudo cgroupfs-mount
#sudo usermod -aG docker $USER
#restart terminal for admin privilege
sudo service docker start
}
dockerphp72apache80html(){
  if [ $# -ne 2 ]; then
    echo "require name,port:$#/2"
  else
    sudo docker run -d --name $1 -p $2:80 -v "$PWD":/var/www/html php:7.2-apache
  fi
}
dockerphp72apache80www(){
  mkdir -p www
  sudo docker run -d --name php72apache -p 80:80 -v "$PWD/www":/var/www php:7.2-apache
}
dockercentos7systemd80(){
  sudo docker run -d --name centos7systemd --privileged -p 80:80 -v "$PWD":/var/www centos/systemd
}
