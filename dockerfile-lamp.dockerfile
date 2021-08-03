FROM kserge2001/centos_ssh
LABEL MAINTAINER muritala
RUN yum update -y && yum install httpd -y 
RUN chkconfig httpd on \
service httpd start
RUN yum install mysql-server -y \
service mysqld start \
chkcfig mysqld on
VOLUME [/var/lib/mysql]
ENV MYSQL_ROOT_PASSWORD=school1
RUN chmod -R 755 /var/lib/mysql/mysql.sock
RUN create database webserver && create user oracle@localhost identified by ‘school1’; \
grant all privileges on webserver.* to oracle@localhost identified by ‘school1’; \
flush privileges; \
exit
RUN  yum install php php-mysql -y 
RUN touch /var/www/html/info.html
RUN echo "<?php phpinfo();?>" >> /var/www/html/info.html
RUN service httpd restart
CMD bin/bash apachectl-D FOREGROUND