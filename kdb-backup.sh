#!/bin/bash
set +x
/bin/mkdir -pv ~/ds_video
/sbin/mount_smbfs //diskstation/video ~/ds_video
/bin/cp -av /Users/Olleg/Documents/secret.kdbx ~/ds_video/Sonstiges/VIDEO_TS.VOB
/usr/sbin/diskutil unmount ~/ds_video
/bin/mkdir -pv ~/ds_music
/sbin/mount_smbfs //diskstation/music ~/ds_music
/bin/cp -av /Users/Olleg/Documents/secret.kdbx ~/ds_music/Sonstiges/Track07.cda
/usr/sbin/diskutil unmount ~/ds_music

