#!/bin/bash
# Variables de configuración 
#----------------------------------------------------
source config.sh
#----------------------------------------------------

# Instalación de Nagios server
# Actualizamos el sistema
apt update

#Instalamos ssh y el gestor de base de datos mongoDB 
apt install ssh -y
apt install mongodb -y

#Instalamos nagios 4
apt install wget unzip zip bash-completion apache2 libapache2-mod-php7.4 php7.4 net-tools autoconf gcc libc6 make apache2-utils libgd-dev libmcrypt-dev make libssl-dev bc gawk dc build-essential snmp libnet-snmp-perl gettext libldap2-dev smbclient fping default-libmysqlclient-dev -y
wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.3.4.tar.gz
tar xzf nagios-4.3.4.tar.gz 
mv nagios-4.3.4 /tmp/nagios4/
rm -rf nagios-4.3.4.tar.gz
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


# Instalamos los plugins nagios para que nos permita monitorizar los parámetros de las máquinas remotas.
cd /tmp/
wget https://github.com/nagios-plugins/nagios-plugins/archive/release-2.2.1.tar.gz
tar zxvf release-2.2.1.tar.gz 
mv nagios-plugins-release-2.2.1  /tmp/nagios-plugin/
rm -rf release-2.2.1.tar.gz
cd /tmp/nagios-plugin/
./tools/setup 
./configure 
make
make install

sudo systemctl restart nagios.service


#---------------------------------------------

# Configuraciones de ficheros nagios para el funcionamiento de la monitorización personalizaa

#---------------------------------------------

# Intalamos el demonio NRPE. Este demonio se encarga de ejecutar comandos check.
cd /tmp/
git clone https://github.com/NagiosEnterprises/nrpe.git 
cd nrpe
autoconf 
./configure
make all
make install
make install-plugin
make install-daemon
make install-config
make install-init
systemctl enable nrpe 
systemctl start nrpe

#---------------------------------------------

# Configuraciones de ficheros nagios para el funcionamiento de la monitorización personalizaa

#---------------------------------------------
cd /tmp/
wget https://github.com/mongodb/mongo-python-driver/archive/2.7rc1.tar.gz
tar xvf 2.7rc1.tar.gz
rm -rf 2.7rc1.tar.gz
cd mongo-python-driver-2.7rc1/
python setup.py install
mv check_mongodb.py /usr/local/nagios/libexec/
cd /home/ubuntu/Practica_FSP/software/scripts
# Cambiamos el fichero nrpe.cfg para permitir el acceso al servidor Nagios añadiendo su ip
cp ../conf/nrpe.cfg  /usr/local/nagios/etc/nrpe.cfg
exit;
# Reiniciamos el servicio para que los cambios se apliquen
systemctl  restart nrpe


#---------------------------------------------

# Monitorizar maquinas

#---------------------------------------------
# Creamos el directorio  servers  y le añadimos lo siguiente
mkdir -p /usr/local/nagios/etc/servers

 cp ../conf/localhost.cfg /usr/local/nagios/etc/objects/localhost.cfg
 cp ../conf/host.cfg /usr/local/nagios/etc/servers/host.cfg
 cp ../conf/observer.cfg /usr/local/nagios/etc/objects/observer.cfg
 cp ../conf/Brother-ahs.cfg /usr/local/nagios/etc/objects/Brother-ahs.cfg
 cp ../conf/Brother-ember.cfg /usr/local/nagios/etc/objects/Brother-ember.cfg
 cp ../conf/Balancer.cfg /usr/local/nagios/etc/objects/Balancer.cfg
 cp ../conf/Mysql-server.cfg /usr/local/nagios/etc/objects/Mysql-server.cfg
 chown nagios.nagios /usr/local/nagios/etc/objects/*



# Reiniciamos el servicio para que los cambios se apliquen
sudo systemctl restart nagios.service


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
cp ../conf/contacts.cfg  /usr/local/nagios/etc/objects/contacts.cfg

# Reiniciamos el servicio para que los cambios se apliquen
/etc/init.d/nagios3 restart



