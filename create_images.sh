#!/bin/bash
cd centos/
./basic_image.sh
cd ..
cd mysql/
docker build -t centos:mysql .
cd ..
cd php/
docker build -t centos:php .
cd ..
cd nginx/
docker build -t centos:nginx .
