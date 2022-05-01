#---------------------------------------------------------------------------------
# Instalacíon del la Sincronización del contenido estático en la capa de Front-End
#---------------------------------------------------------------------------------

# Instalamos el NFS servidor

apt-get install nfs-kernel-server -y

#
 echo "/home/ubuntu/Practica_FSP/software/Pagina-Web 172.31.0.0/16(rw,sync,no_root_squash,no_subtree_check)" > /etc/exports

# 
systemctl restart nfs-kernel-server
