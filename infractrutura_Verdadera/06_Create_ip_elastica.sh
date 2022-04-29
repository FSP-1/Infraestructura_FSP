#!/bin/bash
set -x

# Deshabilitamos la paginación de la salida de los comandos de AWS CLI
# Referencia: https://docs.aws.amazon.com/es_es/cli/latest/userguide/cliv2-migration.html#cliv2-migration-output-pager
export AWS_PAGER=""

# Configuramos el nombre de la instancia a la que le vamos a asignar la IP elástica
INSTANCE_NAME_WWW1=Examen-Nginx01
INSTANCE_NAME_DB=Examen-dbserver

INSTANCE_NAME_WWW2=Examen-Nginx02
INSTANCE_NAME_BALANCER=Examen-BALANCER
INSTANCE_NAME_SERVER=Examen-NFS_SERVER



# Obtenemos el Id de la instancia a partir de su nombre
INSTANCE_ID=$(aws ec2 describe-instances \
            --filters "Name=tag:Name,Values=$INSTANCE_NAME_WWW1" \
                      "Name=instance-state-name,Values=running" \
            --query "Reservations[*].Instances[*].InstanceId" \
            --output text)

INSTANCE_ID2=$(aws ec2 describe-instances \
            --filters "Name=tag:Name,Values=$INSTANCE_NAME_WWW2" \
                      "Name=instance-state-name,Values=running" \
            --query "Reservations[*].Instances[*].InstanceId" \
            --output text)

INSTANCE_ID5=$(aws ec2 describe-instances \
            --filters "Name=tag:Name,Values=$INSTANCE_NAME_BALANCER" \
                      "Name=instance-state-name,Values=running" \
            --query "Reservations[*].Instances[*].InstanceId" \
            --output text)


# Creamos una IP elástica
ELASTIC_IP=$(aws ec2 allocate-address --query PublicIp --output text)

ELASTIC_IP2=$(aws ec2 allocate-address --query PublicIp --output text)

ELASTIC_IP5=$(aws ec2 allocate-address --query PublicIp --output text)


# Asociamos la IP elástica a la instancia del balanceador
aws ec2 associate-address --instance-id $INSTANCE_ID --public-ip $ELASTIC_IP

aws ec2 associate-address --instance-id $INSTANCE_ID2 --public-ip $ELASTIC_IP2

aws ec2 associate-address --instance-id $INSTANCE_ID5 --public-ip $ELASTIC_IP5
