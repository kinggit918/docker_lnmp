FROM centos:latest
MAINTAINER King Hou "jhou@zshield.net"  
RUN echo -e "NETWORKING=yes\nHOSTNAME=localhost.localdomain" > /etc/sysconfig/network   
RUN yum install -y mysql-server mysql  
   
RUN /etc/init.d/mysqld start &&\  
    mysql -e "grant all privileges on *.* to 'root'@'%' identified by 'dockertest';"&&\  
    mysql -e "grant all privileges on *.* to 'root'@'localhost' identified by 'dockertest';"&&\  
    mysql -u root -pdockertest -e "show databases;"  
   
EXPOSE 3306  
   
CMD ["/usr/bin/mysqld_safe"]  
