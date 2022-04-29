#!/bin/sh

# Eintrag in /etc/fstab:
# //192.168.178.201/backup/borg /mnt/borg cifs defaults,noauto,credentials=/home/olleg/.smbcredentials    0 0
# oder
# 192.168.178.201:/volume1/backup/borg /mnt/borg2nas nfs defaults,noauto 0 0

set -x
mount /mnt/borg2nas
/usr/bin/borg prune -v --list --keep-daily=7 --keep-weekly=4 --keep-monthly=3 --prefix=$(hostname -s)- /mnt/borg2nas
umount /mnt/borg2nas
