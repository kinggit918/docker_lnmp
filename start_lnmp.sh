#!/bin/bash
docker run -d  --name mysql -p 3306:3306 -v /data/mysql:/data/mysql -e MYSQL_ROOT_PASSWORD=dockertest -it centos:mysql
docker run -d  --name php -p 9000:9000 -v /var/www/html:/usr/local/nginx/html --link mysql:mysql -it centos:php
docker run -d  --name nginx -p 80:80 -v /var/www/html:/usr/local/nginx/html --link php:php -it centos:nginx
