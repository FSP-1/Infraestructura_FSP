#!/bin/bash
set -x
# Variables
USER_NAME=ubuntu
# Desxargamos el script de  docker 
 curl -fsSL https://get.docker.com -o get-docker.sh

# Ejecutamos el script
 sudo get-docker.sh

 

 # Iniciamos el servicio Docker
 systemctl start docker

 systemctl enable docker 
 
 #Añadimos nuestro usuario al grupo Docker

 usermod -aG docker $USER_NAME


  # Actualizamos el grupo Docker

#  newgrp docker

#Instalamos docker 
 apt install docker-compose -y
