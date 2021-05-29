#!/bin/bash
skeldockermakefile(){
cat > Makefile << 'EOF'
AUTHOR:=nginxproxy
IMAGE:=nginx-proxy
TAG:=latest
OPTION:=-e ENABLE_IPV6=true -e HTTPS_METHOD=noredirect
enable:
	sudo docker update --restart=always $(IMAGE)
disable:
	sudo docker update --restart=no $(IMAGE)
frm:
	sudo docker rm --force $(IMAGE)
bash:
	sudo docker exec -it $(IMAGE) /bin/bash
_run:
	sudo docker run -d \
	--name $(IMAGE) \
	--hostname $(IMAGE) \
	-p 80:80 \
	-p 443:443 \
	-v /var/run/docker.sock:/tmp/docker.sock:ro \
	-v $(PWD)/htpasswd:/etc/nginx/htpasswd \
	-v $(PWD)/vhost.d:/etc/nginx/vhost.d \
	-v $(PWD)/certs:/etc/nginx/certs \
	$(OPTION) \
	$(AUTHOR)/$(IMAGE):$(TAG)
run:_run
EOF
}