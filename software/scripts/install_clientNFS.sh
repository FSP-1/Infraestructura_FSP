#---------------------------------------------------------------------------------
# Instalacíon del la Sincronización del contenido estático en la capa de Front-End
#---------------------------------------------------------------------------------

# Instalamos el NFS cliente 

apt-get install nfs-common -y
#
mount 172.31.92.138:/home/ubuntu/Practica_FSP/software/Pagina-Web /home/ubuntu/Practica_FSP/software/Pagina-Web
#

 sed -i "/LABEL=cloudimg-rootfs/a 172.31.92.138:/home/ubuntu/Practica_FSP/software/Pagina-Web /home/ubuntu/Practica_FSP/software/Pagina-Web  nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0" /etc/fstab

#
systemctl restart nfs-client.target
