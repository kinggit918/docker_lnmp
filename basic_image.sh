#!/bin/bash

yum -y install febootstrap
febootstrap -i bash -i wget -i yum -i iputils -i iproute centos6 centos6-doc http://mirrors.163.com/centos/6/os/x86_64/
cd centos6-doc/
tar -c .|docker import - centos
