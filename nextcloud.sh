#!/bin/bash
wget https://download.nextcloud.com/server/releases/latest.zip
unzip latest.zip
dnf install -y dnf-utils http://rpms.remirepo.net/enterprise/remi-release-9.rpm -y
dnf update -y
dnf module enable php:remi-8.3
dnf install httpd mariadb-server php -y
dnf install php-cli php-fpm php-curl php-mysqlnd php-gd php-opcache php-zip php-intl php-common php-bcmath php-imap php-imagick php-xmlrpc php-json php-readline php-memcached php-redis php-mbstring php-apcu php-xml php-dom php-redis php-memcached php-memcache -y
systemctl enable –now httpd mariadb php-fpm
firewall-cmd –add-service ={http,https} –permanent
systemctl restart httpd
systemctl restart php-fpm
systemctl restart mariadb
