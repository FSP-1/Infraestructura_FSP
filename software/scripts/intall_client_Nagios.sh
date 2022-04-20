#!/bin/bash

# Instalamos los plugins nagios para que nos permita monitorizar los parámetros de las máquinas remotas.
apt install nagios-nrpe-server nagios-nrpe-plugin nagios-plugins -y

#---------------------------------------------

# Configuraciones de ficheros nagios para el funcionamiento de la monitorización

#---------------------------------------------

# Cambiamos el fichero nrpe.cfg para permitir el acceso al servidor Nagios añadiendo su ip y los softwares o hardwares que vamos a chequear
cp ./conf/nrpe.cfg /etc/nagios/nrpe.cfg

# Reiniciamos el servicio para que los cambios se apliquen
systemctl  restart nagios-nrpe-server
