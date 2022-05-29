#!/bin/bash
set -x
# Eintrag in /etc/fstab:
# //192.168.178.201/backup/borg/arch /mnt/borg cifs defaults,noauto,credentials=/home/olleg/.smbcredentials    0 0
# oder
# 192.168.178.201:/volume1/backup/borg/arch /mnt/borg2nas nfs defaults,noauto 0 0
mount /mnt/borg2nas
borg create -s --progress --list --filter AME -C lz4 --exclude-from bexclude.txt /mnt/borg2nas::$(hostname -s)-$(date +%Y-%m-%d,%H:%M) /root /etc /var/lib/libvirt
umount /mnt/borg2nas
