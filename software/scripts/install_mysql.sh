#!/bin/bash
set -x

source config.sh

#----------------------------------------------------

#----------------------------------------------------
# Instalacíon del servidor web
#----------------------------------------------------
apt update
# Instalamos MySQL Server
apt install mysql-server -y

#
rm /tmp/Francodb.sql
cp sql/Francodb.sql /tmp/Francodb.sql
# Cambiamos la contraseña del usuario root
mysql -u root < /tmp/Francodb.sql
mysql -u root <<< "DROP USER IF EXISTS '$DB_USER'@'$PRIVATE_WWW_SUBNET';"
mysql -u root <<< "CREATE USER '$DB_USER'@'$PRIVATE_WWW_SUBNET' IDENTIFIED BY '$DB_PASSWORD';"
mysql -u root <<< "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'$PRIVATE_WWW_SUBNET';"

# Configuramos MySQL para aceptar conexiones desde cualquier interfaz de red
sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf

# Reiniciamos el servicio de MySQL
systemctl restart mysql