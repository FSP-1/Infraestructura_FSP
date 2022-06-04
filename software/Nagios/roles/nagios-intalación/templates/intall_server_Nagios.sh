#!/bin/bash
# Actualizamos los paquetes de la maquinas 
apt update 
#Instalamos ssh y el gestor de base de datos mongoDB 
apt install ssh -y

#Instalamos las dependencias necesarias para nagios 
apt install -y autoconf bc gawk dc build-essential gcc libc6 make wget unzip apache2 php libapache2-mod-php libgd-dev libmcrypt-dev make libssl-dev snmp libnet-snmp-perl gettext

# Instalamos nagios
wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.6.tar.gz
tar -xvf nagios-4.4.6.tar.gz 
rm -rf nagios-4.4.6.tar.gz 
mv nagios-4.4.6 nagios4
cd nagios4
./configure --with-httpd-conf=/etc/apache2/sites-enabled
make all
make install-groups-users 
usermod -a -G nagios www-data
make install
make install-init
make install-commandmode
make install-config
make install-webconf
a2nmod rewrite cgi
htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
cd /home/ubuntu/....
# Instalamos los plugins nagios para que nos permita monitorizar los parámetros de las máquinas remotas.
apt install  nagios-nrpe-plugin monitoring-plugins -y

cfg_file=/usr/local/nagios/etc/objects/observer.cfg
cfg_file=/usr/local/nagios/etc/objects/Brother-ahs.cfg
cfg_file=/usr/local/nagios/etc/objects/Brother-ember.cfg
cfg_file=/usr/local/nagios/etc/objects/Balancer.cfg
cfg_file=/usr/local/nagios/etc/objects/Mysql-server.cfg

#---------------------------------------------
---
- hosts: Nagios 
  become: true
  roles: 
    - netdata
    - HTPPS

- hosts: Nagios 
  become: true
  roles: 
    - nagios-intalación

- hosts: Nrpe 
  become: true
  roles: 
    - nagios_cliente

- hosts: Nagios 
  become: true
  roles: 
    - nagios_config

    
# Configuraciones de ficheros nagios para el funcionamiento de la monitorización

#---------------------------------------------

# ficheros configurados
mkdir /usr/local/nagios/etc/servers
cp ../conf/resource.cfg /usr/local/nagios/etc/resource.cfg
cp ../conf/host.cfg /usr/local/nagios/etc/servers/host.cfg
chmod 775 /usr/local/nagios/etc
chown nagios:nagios /usr/local/nagios/etc/servers/
chown nagios:nagios /usr/local/nagios/etc/servers/host.cfg
chmod 664 /usr/local/nagios/etc/servers/host.cfg

# Reiniciamos el servicio para que los cambios se apliquen
systemctl  restart apache2
systemctl restart nagios

systemctl  enable apache2
systemctl enable nagios


- name:  Instalamos ssh y las dependencias necesarias para nagios 
  shell: |
   apt install ssh -y
   apt install -y autoconf bc gawk dc build-essential gcc libc6 make wget unzip apache2 php libapache2-mod-php libgd-dev libmcrypt-dev make libssl-dev snmp libnet-snmp-perl gettext
  args:
    chdir: /tmp/


- name:  Instalamos nagios parteNº1
  shell: |
   wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.6.tar.gz
   tar -xvf nagios-4.4.6.tar.gz 
   rm -rf nagios-4.4.6.tar.gz 
   mv nagios-4.4.6 nagios4
  args:
    chdir: /tmp/

- name:  Instalamos nagios parteNº2
  shell: |
    ./configure --with-httpd-conf=/etc/apache2/sites-enabled
    make all
    make install-groups-users 
    usermod -a -G nagios www-data
    make install
    make install-init
    make install-commandmode
    make install-config
    make install-webconf
    a2enmod rewrite cgi
  args:
    chdir: /tmp/nagios4

- name: Create nagios admin user
  command: htpasswd -b -c /usr/local/nagios/etc/htpasswd.users nagiosadmin fsp
  ignore_errors: true
  become: true

- name:  Instalamos los plugins nagios para que nos permita monitorizar los parámetros de las máquinas remotas. 
  shell: |
    apt install  nagios-nrpe-plugin monitoring-plugins -y
  args:
    chdir: /tmp/nagios4