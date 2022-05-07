#!/bin/bash
set -x
#----------------------------------------------------

#----------------------------------------------------
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
cp ../conf/check.conf /etc/nginx/sites-available/check.conf
systemctl restart nginx


