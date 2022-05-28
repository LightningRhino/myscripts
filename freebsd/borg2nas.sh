#!/usr/local/bin/bash
set -x
# Eintrag in /etc/fstab:
# 192.168.178.201:/volume1/backup/borg/freebsd /mnt/borg2nas nfs rw,soft,intr,noauto 0 0
mount /mnt/borg2nas
borg create -s --progress --list --filter AME -C lz4 --exclude-from bexclude.txt /mnt/borg2nas::$(hostname -s)-$(date +%Y-%m-%d,%H:%M) /boot /root /etc /home/olleg /zroot/vm
umount /mnt/borg2nas
