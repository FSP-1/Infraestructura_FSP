#!/bin/bash

# Instalamos las dependencias necesarias para intalar nrpe y los puglins de nagios en las maquinas remotas
apt update
apt install libmcrypt-dev git autoconf make libssl-dev bc gawk dc build-essential snmp libnet-snmp-perl gettext libldap2-dev smbclient fping default-libmysqlclient-dev -y 

# Instalamos los plugins nagios para que nos permita monitorizar los parámetros de las máquinas remotas.

cd /tmp/
wget https://github.com/nagios-plugins/nagios-plugins/archive/release-2.2.1.tar.gz
tar zxvf release-2.2.1.tar.gz 
mv nagios-plugins-release-2.2.1  /tmp/nagios-plugin/
rm -rf release-2.3.3.tar.gz
cd /tmp/nagios-plugin/
./tools/setup 
./configure 
make
make install

sudo systemctl restart nagios.service

# Intalamos el demonio NRPE. Este demonio se encarga de ejecutar comandos check.
cd /tmp/
git clone https://github.com/NagiosEnterprises/nrpe.git 
cd nrpe
autoconf 
./configure
make all
make install-groups-users
make install
make install-plugin
make install-daemon
make install-config
make install-init
systemctl enable nrpe 
systemctl start nrpe



#---------------------------------------------

# Configuraciones de ficheros nagios para el funcionamiento de la monitorización

#---------------------------------------------

# Cambiamos el fichero nrpe.cfg para permitir el acceso al servidor Nagios añadiendo su ip y los softwares o hardwares que vamos a chequear
cd /tmp/
git clone https://github.com/justintime/nagios-plugins.git
mv nagios-plugins/check_mem/check_mem.pl /usr/local/nagios/libexec
chown nagios.nagios /usr/local/nagios/libexec/check_mem.pl 
chmod +x /usr/local/nagios/libexec/check_mem.pl
cd /home/ubuntu/Practica_FSP/software/scripts
cp ../conf/nrpe.cfg /usr/local/nagios/etc/nrpe.cfg

# Reiniciamos el servicio para que los cambios se apliquen
systemctl  restart nrpe

