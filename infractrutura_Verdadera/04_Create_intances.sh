#!/bin/bash
set -x

# Deshabilitamos la paginación de la salida de los comandos de AWS CLI
# Referencia: https://docs.aws.amazon.com/es_es/cli/latest/userguide/cliv2-migration.html#cliv2-migration-output-pager
export AWS_PAGER=""
# ---------------------------------------------
# Variable Conf
AMI_ID=ami-0472eef47f816e45d
COUNT=1
INTANCE_TYPE=t2.micro
KEY_NAME=IAW2
SECURIRY_GROUP=nginx-sg

SECURIRY_GROUP2=backup-sg
SECURIRY_GROUP3=Balancer-sg
SECURIRY_GROUP4=nfs-sg
SECURIRY_GROUP5=PHP-sg

INSTANCE_NAME_WWW1=Examen-Nginx01
INSTANCE_NAME_DB=Examen-Mysqlserver

INSTANCE_NAME_WWW2=Examen-Nginx02
INSTANCE_NAME_BALANCER=Examen-BALANCER
INSTANCE_NAME_SERVER=Examen-NFS_SERVER
INSTANCE_NAME_PHP=Examen-PHP
INSTANCE_NAME_PHP2=Examen-PHP2

# -----------------------------------


# Fronted-01
aws ec2 run-instances \
    --image-id $AMI_ID \
    --count $COUNT \
    --instance-type $INTANCE_TYPE \
    --key-name $KEY_NAME \
    --security-groups $SECURIRY_GROUP \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME_WWW1}]"
    --user-data file:///home/asir05/AWS_Practica_FSP/Eliminar_contenido.sh


# Bakend
aws ec2 run-instances \
    --image-id $AMI_ID \
    --count $COUNT \
    --instance-type $INTANCE_TYPE \
    --key-name $KEY_NAME \
    --security-groups $SECURIRY_GROUP2 \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME_DB}]"
     --user-data file:///home/asir05/AWS_Practica_FSP/Eliminar_contenido.sh

# Fronted-02
aws ec2 run-instances \
    --image-id $AMI_ID \
    --count $COUNT \
    --instance-type $INTANCE_TYPE \
    --key-name $KEY_NAME \
    --security-groups $SECURIRY_GROUP \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME_WWW2}]"
       --user-data file:///home/asir05/AWS_Practica_FSP/Eliminar_contenido.sh

# Balancer
aws ec2 run-instances \
    --image-id $AMI_ID \
    --count $COUNT \
    --instance-type $INTANCE_TYPE \
    --key-name $KEY_NAME \
    --security-groups $SECURIRY_GROUP3 \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME_BALANCER}]"
        --user-data file:///home/asir05/AWS_Practica_FSP/Eliminar_contenido.sh

# NFS Server
aws ec2 run-instances \
    --image-id $AMI_ID \
    --count $COUNT \
    --instance-type $INTANCE_TYPE \
    --key-name $KEY_NAME \
    --security-groups $SECURIRY_GROUP4 \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME_SERVER}]"
    --user-data file:///home/asir05/AWS_Practica_FSP/Eliminar_contenido.sh

# PHP Server
aws ec2 run-instances \
    --image-id $AMI_ID \
    --count $COUNT \
    --instance-type $INTANCE_TYPE \
    --key-name $KEY_NAME \
    --security-groups $SECURIRY_GROUP5 \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME_PHP}]"
        --user-data file:///home/asir05/AWS_Practica_FSP/Eliminar_contenido.sh

# PHP Server
aws ec2 run-instances \
    --image-id $AMI_ID \
    --count $COUNT \
    --instance-type $INTANCE_TYPE \
    --key-name $KEY_NAME \
    --security-groups $SECURIRY_GROUP5 \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME_PHP2}]"
        --user-data file:///home/asir05/AWS_Practica_FSP/Eliminar_contenido.sh
