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
dockerphp72apache80(){
  if [ $# -ne 1 ]; then
    echo "require args:$#/1"
    exit 1
  fi
  mkdir -p www
  sudo docker run -d --name $1 -p 80:80 -v "$PWD":/var/www php:7.2-apache
}
dockerphp72apache80www(){
  mkdir -p www
  sudo docker run -d -p 80:80 -v "$PWD/www":/var/www php:7.2-apache
}
