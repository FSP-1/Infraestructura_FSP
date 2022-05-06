# 
FROM ubuntu:21.04

LABEL AUTOR="Franco Sergio Peryra"

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && \
  apt install -y apache2 && \
  apt install -y php && \
  apt install -y libapache2-mod-php && \
  apt install -y php-mysql  && \
  rm -rf /var/lib/apt/lists/* 
  
EXPOSE 80

ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

    
