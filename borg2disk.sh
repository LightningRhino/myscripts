#!/bin/bash
set -x
borg create -s --list --filter AME -C lz4 -e '*/.snapshots' /mnt/usbdisk/borg2disk::$(hostname -s)-$(date +%Y-%m-%d,%H:%M) /etc /var/lib/libvirt /root
