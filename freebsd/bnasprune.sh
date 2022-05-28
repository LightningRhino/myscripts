#!/usr/local/bin/bash

set -x
mount /mnt/borg2nas
/usr/local/bin/borg prune -v --list --keep-daily=7 --keep-weekly=4 --keep-monthly=3 --prefix=$(hostname -s)- /mnt/borg2nas
umount /mnt/borg2nas
