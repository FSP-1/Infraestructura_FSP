#!/bin/bash
set -x

# Deshabilitamos la paginación de la salida de los comandos de AWS CLI
# Referencia: https://docs.aws.amazon.com/es_es/cli/latest/userguide/cliv2-migration.html#cliv2-migration-output-pager
export AWS_PAGER=""

# Grupo de seguridad para FRONT_END
aws ec2 create-security-group \
    --group-name nginx-sg \
    --description "Reglas para el frontend"

# Cramos una regla de accesso   SSH
    aws ec2 authorize-security-group-ingress \
    --group-name nginx-sg \
    --protocol tcp \
    --port 22 \
    --cidr 0.0.0.0/0

    # Cramos una regla de accesso  HTPP
    aws ec2 authorize-security-group-ingress \
    --group-name nginx-sg \
    --protocol tcp \
    --port 80 \
    --cidr 0.0.0.0/0


 # Cramos una regla de accesso   NFS
    aws ec2 authorize-security-group-ingress \
    --group-name nginx-sg \
    --protocol tcp \
    --port 2049 \
    --cidr 0.0.0.0/0

# --------------------------------------------
# Grupo de seguridad para backup
aws ec2 create-security-group \
    --group-name backup-sg \
    --description "Reglas para el backup"

    # Cramos una regla de accesso   SSH
    aws ec2 authorize-security-group-ingress \
    --group-name backup-sg \
    --protocol tcp \
    --port 22 \
    --cidr 0.0.0.0/0

     # Cramos una regla de accesso   Mysql
    aws ec2 authorize-security-group-ingress \
    --group-name backup-sg \
    --protocol tcp \
    --port 3306 \
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

# Grupo de seguridad para PHP
aws ec2 create-security-group \
    --group-name PHP-sg \
    --description "Reglas para el backup"

    # Cramos una regla de accesso   SSH
    aws ec2 authorize-security-group-ingress \
    --group-name PHP-sg \
    --protocol tcp \
    --port 22 \
    --cidr 0.0.0.0/0

 # Cramos una regla de accesso   NFS
    aws ec2 authorize-security-group-ingress \
    --group-name PHP-sg \
    --protocol tcp \
    --port 9000 \
    --cidr 0.0.0.0/0

# --------------------------------------------
