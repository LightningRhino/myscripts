#!/bin/bash
set -x
OLDSNAP="2022-03-04"
NEWSNAP="$(date +%Y-%m-%d)"
DEST="/mnt/usbdisk/btrfs-snaps"
DISK="/mnt/usbdisk"

#root
btrfs subvolume snapshot -r / /.snapshots/rootsnap-$NEWSNAP
btrfs send -p /.snapshots/rootsnap-$OLDSNAP /.snapshots/rootsnap-$NEWSNAP | btrfs receive $DEST/rootsnap
btrfs subvolume delete /.snapshots/rootsnap-$OLDSNAP
#btrfs subvolume delete $DEST/rootsnap/rootsnap-$OLDSNAP

#home
btrfs subvolume snapshot -r /home /home/.snapshots/homesnap-$NEWSNAP
btrfs send -p /home/.snapshots/homesnap-$OLDSNAP /home/.snapshots/homesnap-$NEWSNAP | btrfs receive $DEST/homesnap
btrfs subvolume delete /home/.snapshots/homesnap-$OLDSNAP
btrfs subvolume delete $DEST/homesnap/homesnap-$OLDSNAP

set +x
echo "**** Lokale Snapshots: ****"
btrfs subvolume list / | grep 2022
echo "***************************"
echo "**** Snapshots auf $DISK: ****"
btrfs subvolume list $DISK
