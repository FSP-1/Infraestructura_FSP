#!/bin/bash
set -x

# Deshabilitamos la paginación de la salida de los comandos de AWS CLI
# Referencia: https://docs.aws.amazon.com/es_es/cli/latest/userguide/cliv2-migration.html#cliv2-migration-output-pager
export AWS_PAGER=""
# ---------------------------------------------
# Variable Conf
AMI_ID=ami-0472eef47f816e45d
COUNT=1
INTANCE_TYPE=t2.small
KEY_NAME=IAW
SECURIRY_GROUP=Brothers
SECURIRY_GROUP3=Balancer-sg
SECURIRY_GROUP4=nfs-sg
SECURIRY_GROUP5=nagios

INSTANCE_NAME_WWW1=Ash-Twin
INSTANCE_NAME_WWW2=Ember_Twin
INSTANCE_NAME_BALANCER=Balancer
INSTANCE_NAME_SERVER=nfs_server
INSTANCE_NAME_NAGIOS=Nagios_server


# -----------------------------------


# Fronted-01
aws ec2 run-instances \
    --image-id $AMI_ID \
    --count $COUNT \
    --instance-type $INTANCE_TYPE \
    --key-name $KEY_NAME \
    --security-groups $SECURIRY_GROUP \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME_WWW1}]"



# Fronted-02
aws ec2 run-instances \
    --image-id $AMI_ID \
    --count $COUNT \
    --instance-type $INTANCE_TYPE \
    --key-name $KEY_NAME \
    --security-groups $SECURIRY_GROUP \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME_WWW2}]"

# Balancer
aws ec2 run-instances \
    --image-id $AMI_ID \
    --count $COUNT \
    --instance-type $INTANCE_TYPE \
    --key-name $KEY_NAME \
    --security-groups $SECURIRY_GROUP3 \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME_BALANCER}]"

# NFS Server
aws ec2 run-instances \
    --image-id $AMI_ID \
    --count $COUNT \
    --instance-type $INTANCE_TYPE \
    --key-name $KEY_NAME \
    --security-groups $SECURIRY_GROUP4 \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME_SERVER}]"

# PHP Server
aws ec2 run-instances \
    --image-id $AMI_ID \
    --count $COUNT \
    --instance-type $INTANCE_TYPE \
    --key-name $KEY_NAME \
    --security-groups $SECURIRY_GROUP5 \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME_NAGIOS}]"

