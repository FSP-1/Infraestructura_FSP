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
# Intalamos AWSCLI 
apt install zip -y
cd /tmp/
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip

 ./aws/install
aws --version

rm /etc/localtime
ln -s /usr/share/zoneinfo/Europe/Madrid /etc/localtime	

ssh-keygen

scp -i IAW2.pem ubuntu@54.173.51.24:/home/ubuntu/.ssh/id_rsa.pub .

## cat id_rsa.pub | ssh -i aws-ansible.pem ubuntu@18.206.58.248 "cat - >> /home/ubuntu/.ssh/authorized_keys2"