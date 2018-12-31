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
