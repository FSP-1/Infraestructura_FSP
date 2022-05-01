#!/bin/bash
# Variables de configuración 
#----------------------------------------------------
source config.sh
#----------------------------------------------------

# Actualizamos el sistema
apt update
# apt upgrade -y

# Instalamos El servidor NGINX
apt install nginx -y

# Configuración de Nginx
cp ../conf/check.conf /etc/nginx/sites-available/default
systemctl restart nginx

#Instalamos ssh y el gestor de base de datos mongoDB 
apt install ssh -y
apt install mongodb -y

#Instalamos nagios 4
apt install nagios4 -y
exit;
# Instalamos los plugins nagios para que nos permita monitorizar los parámetros de las máquinas remotas.
apt install nagios-nrpe-server nagios-nrpe-plugin nagios-plugins -y

#Instalamos zip
apt install zip -y

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

# Primero instalamos los plugins necesarios, que descargaremos de la siguiente cuenta de github:
wget --no-check-certificate https://github.com/mzupan/nagios-plugin-mongodb/archive/master.zip
unzip master.zip -d nagios-plugin-mongodb
rm master.zip
apt-get install python-dev python-pip
pip install pymongo
mv nagios-plugin-mongodb/check_mongodb.py /etc/nagios-plugins/config/

# Luego intalamos lo drivers que también lo descargaremos de la siguiente cuenta de github
wget --no-check-certificate https://github.com/mongodb/mongo-python-driver/archive/master.zip
unzip master.zip
cd mongo-python-driver-master/
python setup.py install

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



