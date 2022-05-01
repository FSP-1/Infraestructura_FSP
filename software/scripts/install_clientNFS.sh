#---------------------------------------------------------------------------------
# Instalacíon del la Sincronización del contenido estático en la capa de Front-End
#---------------------------------------------------------------------------------

# Instalamos el NFS cliente 

apt-get install nfs-common -y
#
mount 172.31.92.138:/Practica_FSP/software/ /Practica_FSP/software/
#

 sed -i "/LABEL=cloudimg-rootfs/a 172.31.92.138:/Practica_FSP/software/Pagina-Web /Practica_FSP/software/Pagina-Web  nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0" /etc/fstab

#
systemctl restart nfs-client.target
