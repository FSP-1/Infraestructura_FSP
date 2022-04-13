#---------------------------------------------------------------------------------
# Instalacíon del la Sincronización del contenido estático en la capa de Front-End
#---------------------------------------------------------------------------------

# Instalamos el NFS cliente 

apt-get install nfs-common -y
#
mount 172.31.90.154:/var/www/html /var/www/html
#

 sed -i "/LABEL=cloudimg-rootfs/a  172.31.90.154:/Practica_FSP/software/Pagina-Web/src /Practica_FSP/software/Pagina-Web/scr  nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0" /etc/fstab

#
systemctl restart nfs-client.target
