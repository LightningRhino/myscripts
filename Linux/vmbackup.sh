#!/bin/bash
set -x
systemctl start libvirt-nosleep.service
mkdir -p /mnt/synology
#mount -t cifs -o credentials=/home/olleg/.smbcredentials //192.168.178.201/sonstiges /mnt/synology/
mount -t nfs 192.168.178.201:/volume1/sonstiges /mnt/synology
#rsync -avhP /var/lib/libvirt/images/win11pro.qcow2 /mnt/synology/kvm/win11pro/
#rsync -avhP /var/lib/libvirt/qemu/nvram/win11pro_VARS.fd /mnt/synology/kvm/win11pro/
#virsh dumpxml win11pro > /root/win11pro.xml && mv /root/win11pro.xml /mnt/synology/kvm/win11pro/
rsync -avhP /var/lib/libvirt/images/win10-gaming.qcow2 /mnt/synology/kvm/win10-gaming/
rsync -avhP /var/lib/libvirt/qemu/nvram/win10-gaming_VARS.fd /mnt/synology/kvm/win10-gaming/
virsh dumpxml win10-gaming > /root/win10-gaming.xml && mv /root/win10-gaming.xml /mnt/synology/kvm/win10-gaming/
systemctl stop libvirt-nosleep.service
umount /mnt/synology
