#!/bin/bash
skeldockermakefile(){
cat > Makefile << 'EOF'
AUTHOR := skel
IMAGE := skel
TAG := latest
PORT := 65535
all:
	@echo make dockerfile,dockerbuild,build,rm,frm,enable,disable,ps,run,stop,bash
dockerfile:
	@rm -f Dockerfile
	@echo 'FROM centos/systemd'>>Dockerfile
	@echo 'RUN yum -y update; yum clean all;'>>Dockerfile
	@echo 'RUN yum -y install curl libcurl-devel openssl-devel wget nano vim git zip expect bc mariadb httpd httpd-devel mod_ssl; yum clean all; systemctl enable httpd.service'>>Dockerfile
	@echo 'RUN yum -y install http://rpms.famillecollet.com/enterprise/remi-release-7.rpm'>>Dockerfile
	@echo 'RUN yum -y install --enablerepo=remi,remi-php72 php php-mbstring php-pdo php-gd php-pecl-redis php-mysql php-pecl-mcrypt'>>Dockerfile
	@echo 'RUN echo "<VirtualHost *:80>">>/etc/httpd/conf.d/vhost.00-default.conf'>>Dockerfile
	@echo 'RUN echo "  ServerName __default__">>/etc/httpd/conf.d/vhost.00-default.conf'>>Dockerfile
	@echo 'RUN echo "  DocumentRoot /var/www/html">>/etc/httpd/conf.d/vhost.00-default.conf'>>Dockerfile
	@echo 'RUN echo "  DirectoryIndex index.php index.html index.htm">>/etc/httpd/conf.d/vhost.00-default.conf'>>Dockerfile
	@echo 'RUN echo "  <Directory /var/www/html>">>/etc/httpd/conf.d/vhost.00-default.conf'>>Dockerfile
	@echo 'RUN echo "    Options Indexes FollowSymLinks">>/etc/httpd/conf.d/vhost.00-default.conf'>>Dockerfile
	@echo 'RUN echo "    AllowOverride All">>/etc/httpd/conf.d/vhost.00-default.conf'>>Dockerfile
	@echo 'RUN echo "  </Directory>">>/etc/httpd/conf.d/vhost.00-default.conf'>>Dockerfile
	@echo 'RUN echo "</VirtualHost>">>/etc/httpd/conf.d/vhost.00-default.conf'>>Dockerfile
	@echo 'ENV TZ=Asia/Tokyo'>>Dockerfile
	@echo 'RUN echo "ZONE=Asia/Tokyo" > /etc/sysconfig/clock '>>Dockerfile
	@echo 'RUN rm -f /etc/localtime'>>Dockerfile
	@echo 'RUN ln -fs /usr/share/zoneinfo/Asia/Tokyo /etc/localtime'>>Dockerfile
	@echo 'RUN yum -y install cronie'>>Dockerfile
	@echo 'RUN echo "* * * * * /var/www/cron/cron.sh">>/var/spool/cron/root'>>Dockerfile
	@echo 'RUN yum -y install --enablerepo=remi jq nkf'>>Dockerfile
	@echo 'COPY override/ /'>>Dockerfile
	@echo 'CMD ["/usr/sbin/init"]'>>Dockerfile
dockerbuild:
	@mkdir -p override
	sudo docker build -t $(AUTHOR)/$(IMAGE):$(TAG) .
	@rmdir override --ignore-fail-on-non-empty
fdockerbuild:
	@mkdir -p override
	sudo docker build --rm -t $(AUTHOR)/$(IMAGE):$(TAG) .
	@rmdir override --ignore-fail-on-non-empty
build: dockerfile fdockerbuild
	@rm -f Dockerfile
rm:
	sudo docker rm $(IMAGE)
frm:
	sudo docker rm --force $(IMAGE)
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
