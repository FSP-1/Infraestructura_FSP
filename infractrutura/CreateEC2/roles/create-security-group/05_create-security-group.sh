#!/bin/bash
set -x

# Deshabilitamos la paginación de la salida de los comandos de AWS CLI
# Referencia: https://docs.aws.amazon.com/es_es/cli/latest/userguide/cliv2-migration.html#cliv2-migration-output-pager
export AWS_PAGER=""

# Grupo de seguridad para FRONT_END
aws ec2 create-security-group \
    --group-name Brothers \
    --description "Reglas para el frontend"

# Cramos una regla de accesso   SSH
    aws ec2 authorize-security-group-ingress \
    --group-name Brothers \
    --protocol tcp \
    --port 22 \
    --cidr 0.0.0.0/0

    # Cramos una regla de accesso  HTPP
    aws ec2 authorize-security-group-ingress \
    --group-name Brothers \
    --protocol tcp \
    --port 80 \
    --cidr 0.0.0.0/0


 # Cramos una regla de accesso   NFS
    aws ec2 authorize-security-group-ingress \
    --group-name Brothers \
    --protocol tcp \
    --port 2049 \
    --cidr 0.0.0.0/0

 # Cramos una regla de accesso   NRPE
    aws ec2 authorize-security-group-ingress \
    --group-name Brothers \
    --protocol tcp \
    --port 5666 \
    --cidr 0.0.0.0/0

 # Cramos una regla de accesso  Netdata
    aws ec2 authorize-security-group-ingress \
    --group-name Brothers \
    --protocol tcp \
    --port 19999 \
    --cidr 0.0.0.0/0
# --------------------------------------------

# Grupo de seguridad para Balancer
aws ec2 create-security-group \
    --group-name Balancer-sg \
    --description "Reglas para el frontend"

# Cramos una regla de accesso   SSH
    aws ec2 authorize-security-group-ingress \
    --group-name Balancer-sg \
    --protocol tcp \
    --port 22 \
    --cidr 0.0.0.0/0

    # Cramos una regla de accesso  HTPP
    aws ec2 authorize-security-group-ingress \
    --group-name Balancer-sg \
    --protocol tcp \
    --port 80 \
    --cidr 0.0.0.0/0

    # Cramos una regla de accesso  HTPPS
    aws ec2 authorize-security-group-ingress \
    --group-name Balancer-sg \
    --protocol tcp \
    --port 443 \
    --cidr 0.0.0.0/0

 # Cramos una regla de accesso   NRPE
    aws ec2 authorize-security-group-ingress \
    --group-name Balancer-sg \
    --protocol tcp \
    --port 5666 \
    --cidr 0.0.0.0/0

    # --------------------------------------------

# Grupo de seguridad para NFS
aws ec2 create-security-group \
    --group-name nfs-sg \
    --description "Reglas para el backup"

    # Cramos una regla de accesso   SSH
    aws ec2 authorize-security-group-ingress \
    --group-name nfs-sg \
    --protocol tcp \
    --port 22 \
    --cidr 0.0.0.0/0

 # Cramos una regla de accesso   NFS
    aws ec2 authorize-security-group-ingress \
    --group-name nfs-sg \
    --protocol tcp \
    --port 2049 \
    --cidr 0.0.0.0/0

# --------------------------------------------

   # --------------------------------------------

# Grupo de seguridad para Nagios
aws ec2 create-security-group \
    --group-name nagios \
    --description "Reglas para el backup"

    # Cramos una regla de accesso   SSH
    aws ec2 authorize-security-group-ingress \
    --group-name nagios \
    --protocol tcp \
    --port 22 \
    --cidr 0.0.0.0/0

    # Cramos una regla de accesso  HTPP
    aws ec2 authorize-security-group-ingress \
    --group-name nagios \
    --protocol tcp \
    --port 80 \
    --cidr 0.0.0.0/0

    # Cramos una regla de accesso  HTPPS
    aws ec2 authorize-security-group-ingress \
    --group-name nagios \
    --protocol tcp \
    --port 443 \
    --cidr 0.0.0.0/0

 # Cramos una regla de accesso   NRPE
    aws ec2 authorize-security-group-ingress \
    --group-name nagios \
    --protocol tcp \
    --port 5666 \
    --cidr 0.0.0.0/0

# --------------------------------------------
# Grupo de seguridad para Ansible
aws ec2 create-security-group \
    --group-name ansible \
    --description "Reglas para el backup"

    # Cramos una regla de accesso   SSH
    aws ec2 authorize-security-group-ingress \
    --group-name ansible \
    --protocol tcp \
    --port 22 \
    --cidr 0.0.0.0/0

 # Cramos una regla de accesso   NRPE
    aws ec2 authorize-security-group-ingress \
    --group-name ansible \
    --protocol tcp \
    --port 5666 \
    --cidr 0.0.0.0/0

# ------------------------------------------------
# Grupo de seguridad para mysql
aws ec2 create-security-group \
    --group-name mysql \
    --description "Reglas para el backup"

    # Cramos una regla de accesso   SSH
    aws ec2 authorize-security-group-ingress \
    --group-name mysql \
    --protocol tcp \
    --port 22 \
    --cidr 0.0.0.0/0

     # Cramos una regla de accesso   Mysql
    aws ec2 authorize-security-group-ingress \
    --group-name mysql \
    --protocol tcp \
    --port 3306 \
    --cidr 0.0.0.0/0
