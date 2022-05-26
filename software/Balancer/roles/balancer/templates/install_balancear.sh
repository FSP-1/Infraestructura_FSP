#!/bin/bash
set -x
#----------------------------------------------------

#----------------------------------------------------
# Variables de configuración 
#----------------------------------------------------

source config.sh
#----------------------------------------------------

#----------------------------------------------------
# Instalacíon de la pila LAMP
#----------------------------------------------------
# Actualizamos el sistema
apt update
# apt upgrade -y

# Instalamos El servidor NGINX
apt install nginx -y


# Copiamos el fichero de Configuración de Nginx
cp ../conf/default_balancer.conf /etc/nginx/sites-available/default


# Reiniciamos el servicio
systemctl restart nginx

#----------------------------------------
# Configuramos HTPPS
#----------------------------------------


# Realizams la instalacion de snapd
snap install core
snap refresh core

# Eliminamos instalaciones previas de certbot con apt
apt-get remove certbot

# Instalamos certbot con snap
snap install --classic certbot

# Solicitamos el certificado HTTPS
sudo certbot --nginx -m $EMAIL_HTPPS --agree-tos --no-eff-email -d $DOMAIN


