#!/bin/bash
skeldockermakefile(){
cat > Makefile << 'EOF'
AUTHOR := skel
IMAGE := skel
TAG := latest
PORT := 65535
all:
	@echo make dockerfile,dockerbuild,build,rm,enable,disable,ps,run,stop,bash
dockerfile:
	@echo -e 'FROM centos/systemd'>>Dockerfile
	@echo -e 'RUN yum -y update; yum -y install curl libcurl-devel openssl-devel wget nano vim git expect zip jq httpd httpd-devel mod_ssl; yum clean all; systemctl enable httpd.service'>>Dockerfile
	@echo -e 'RUN yum -y install http://rpms.famillecollet.com/enterprise/remi-release-7.rpm'>>Dockerfile
	@echo -e 'RUN yum -y install --enablerepo=remi,remi-php72 php php-mbstring php-pdo php-gd php-pecl-redis php-mysql php-pecl-mcrypt'>>Dockerfile
	@echo -e 'RUN echo "<VirtualHost *:80>">>/etc/httpd/conf.d/vhost.00-default.conf'>>Dockerfile
	@echo -e 'RUN echo "ServerName __default__">>/etc/httpd/conf.d/vhost.00-default.conf'>>Dockerfile
	@echo -e 'RUN echo "DocumentRoot /var/www/html">>/etc/httpd/conf.d/vhost.00-default.conf'>>Dockerfile
	@echo -e 'RUN echo "<Directory /var/www/html>">>/etc/httpd/conf.d/vhost.00-default.conf'>>Dockerfile
	@echo -e 'RUN echo "Options Indexes FollowSymLinks">>/etc/httpd/conf.d/vhost.00-default.conf'>>Dockerfile
	@echo -e 'RUN echo "AllowOverride All">>/etc/httpd/conf.d/vhost.00-default.conf'>>Dockerfile
	@echo -e 'RUN echo "</Directory>">>/etc/httpd/conf.d/vhost.00-default.conf'>>Dockerfile
	@echo -e 'RUN echo "</VirtualHost>">>/etc/httpd/conf.d/vhost.00-default.conf'>>Dockerfile
	@echo -e 'COPY override/ /'>>Dockerfile
	@echo -e 'CMD ["/usr/sbin/init"]'>>Dockerfile
dockerbuild:
	@mkdir -p override
	sudo docker build --rm \
	-t $(AUTHOR)/$(IMAGE):$(TAG) .
	@rmdir override --ignore-fail-on-non-empty
build: dockerfile dockerbuild
	@rm -f Dockerfile
rm:
	sudo docker rm $(IMAGE)
enable:
	sudo docker update --restart=always $(IMAGE)
disable:
	sudo docker update --restart=no $(IMAGE)
ps:
	sudo docker ps -a -f name=$(IMAGE)
run:
	sudo docker run -d \
	--privileged \
	--name $(IMAGE) \
	--hostname $(IMAGE) \
	-p $(PORT):80 \
	-v "$(PWD)/www":/var/www \
	$(AUTHOR)/$(IMAGE):$(TAG)
stop:
	sudo docker stop $(IMAGE)
bash:
	sudo docker exec -it $(IMAGE) /bin/bash
EOF
}
