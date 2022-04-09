#!/bin/bash
set -x
#cryptsetup open --key-file=/etc/cryptkey --type luks2 /dev/sdb usbdisk
#mount /dev/mapper/usbdisk /mnt/usbdisk
cryptsetup open --key-file=/etc/cryptkey --type luks2 /dev/disk/by-uuid/e99fe78d-d11e-4023-a398-ff1a64b66a3a usbdisk
mount /dev/disk/by-uuid/c0f056e6-8fa4-4713-b782-6831b41e134b -o compress=zstd,discard=async,commit=120 /mnt/usbdisk
#unmount with: $ umount /mnt/usbdisk && cryptsetup close usbdisk
