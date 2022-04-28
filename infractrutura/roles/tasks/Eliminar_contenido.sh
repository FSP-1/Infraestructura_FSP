#!/bin/bash
set -x

#Eliminamos el contenido de la instancia
sudo apt purge -y mssql* msodbc*


sudo rm -rf /var/opt/mssql
sudo apt update -y 
