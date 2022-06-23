#!/bin/sh
/sbin/zfs list -t snapshot -o name | /usr/bin/grep -i ${1}'@' | /usr/bin/sort -r | /usr/bin/tail -n +3 | /usr/bin/xargs -n 1 /sbin/zfs destroy -r
/usr/local/sbin/vm snapshot -f $1
