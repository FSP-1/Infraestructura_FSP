#!/bin/bash
# Variables de configuración 
#----------------------------------------------------
source config.sh
#----------------------------------------------------

# Actualizamos el sistema
apt update
# apt upgrade -y

# Instalamos El servidor NGINX
#apt install nginx -y

# Configuración de Nginx
#cp ../conf/check.conf /etc/nginx/sites-available/default
#systemctl restart nginx

#Instalamos ssh y el gestor de base de datos mongoDB 
apt install ssh -y
apt install mongodb -y

#Instalamos nagios 4
apt install wget unzip vim curl gcc openssl build-essential libgd-dev libssl-dev libapache2-mod-php php-gd php apache2 -y
wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.6.tar.gz
tar zxvf nagios-4.4.6.tar.gz 
mv nagios-4.4.6 /tmp/nagios4/
rm -rf nagios-4.4.6.tar.gz
cd /tmp/nagios4/
./configure --with-httpd-conf=/etc/apache2/sites-enabled
make all
useradd nagios
make install
make install-init
make install-commandmode
systemctl enable nagios.service
make install-config
make install-webconf
htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
a2enmod cgi
systemctl restart apache2
systemctl start nagios
systemctl enable nagios
exit;

# Instalamos los plugins nagios para que nos permita monitorizar los parámetros de las máquinas remotas.
apt install libmcrypt-dev make libssl-dev bc gawk dc build-essential snmp libnet-snmp-perl gettext libldap2-dev smbclient fping libmysqlclient-dev libdbi-dev -y
cd /tmp/
wget https://github.com/nagios-plugins/nagios-plugins/archive/release-2.3.3.tar.gz 
tar zxvf release-2.3.3.tar.gz 
mv nagios-plugins-release-2.3.3  /tmp/nagios-plugin/
rm -rf release-2.3.3.tar.gz
cd /tmp/nagios-plugin/
./tools/setup 
./configure 
make
make install

sudo systemctl restart nagios.service
#---------------------------------------------

# Configuraciones de ficheros nagios para el funcionamiento de la monitorización

#---------------------------------------------

# Cambiamos el fichero nrpe.cfg para permitir el acceso al servidor Nagios añadiendo su ip
cp ./conf/nrpe.cfg /etc/nagios/nrpe.cfg

# Reiniciamos el servicio para que los cambios se apliquen
systemctl  restart nagios-nrpe-server


#---------------------------------------------

# Monitorizar maquinas

#---------------------------------------------

# Creamos el fichero host.cfg y le añadimos lo siguienye
 cp ./conf/host.cfg /etc/nagios3/conf.d/host.cfg

# Reiniciamos el servicio para que los cambios se apliquen
/etc/init.d/nagios3 restart


#---------------------------------------------

# Monitorizar los servicios de esta maquina

#---------------------------------------------



# Modificamos el fichero commands.cfg para poder moterizar los servicios de esta maquina
cp ./conf/commands.cfg /etc/nagios3/commands.cfg


#---------------------------------------------

# Monitorizar los servicios de las maquinas remotas 

#---------------------------------------------

# Modificamos el fichero servicios-fisico.cfg para poder moterizar los servicios de las maquina remotamente
cp ./conf/servicios-fisico.cfg /etc/nagios3/conf.d/servicios-fisico.cfg


#---------------------------------------------

# Aviso vía correo electrónico (SSMTP)

#---------------------------------------------

# Primero instalamos el servidor de correo ssmtp

apt install ssmtp -y

# Modificamos el fichero ssmtp.conf para poder enviarnos mensajes a nuestras cuentas electrónicas
cp ./conf/ssmtp.conf /etc/ssmtp/ssmtp.conf

# Modificamos el fichero contacts_nagios2.cfg para poder enviarnos mensajes a nuestras cuentas electrónicas
cp ./conf/contacts_nagios2.cfg /etc/nagios3/conf.d/contacts_nagios2.cfg

# Reiniciamos el servicio para que los cambios se apliquen
/etc/init.d/nagios3 restart



