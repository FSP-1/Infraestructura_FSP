#!/bin/bash
set -x
#----------------------------------------------------

#----------------------------------------------------
#----------------------------------------------------
# Actualizamos el sistema
 apt-get update
 apt-add-repository -y ppa:ansible/ansible

 # Instalamos Ansible
  apt-get update
  apt-get install -y ansible

# Instalamos phyton
 apt install python3-pip -y

# Instalamos Boto Framework - AWS SDK para que ansible pueda llegar a AWS usando boto SDK
 pip install boto boto3
 apt-get install python3-boto -y
#
apt install zip -y
cd /tmp/
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip

 ./aws/install
aws --version

rm /etc/localtime
ln -s /usr/share/zoneinfo/Europe/Madrid /etc/localtime	
 mkdir -p Brothers/{inventory,group_vars,roles}

 mkdir -p Docker-Build/{handlers,tasks,templates}
  mkdir -p NFS_client/{handlers,tasks,templates}