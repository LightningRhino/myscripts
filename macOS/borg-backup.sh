#!/bin/sh

set +x

# Setting this, so the repo does not need to be given on the commandline:
export BORG_REPO='/Users/Olleg/.borg'

# See the section "Passphrase notes" for more infos.
export BORG_PASSPHRASE='PASS'

# some helpers and error handling:
info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

info "Starte Backup"

# Backup the most important directories into an archive named after
# the machine this script is currently running on:

/opt/homebrew/bin/borg create -s --list --filter AME -C lz4 --exclude-from /Users/Olleg/.scripts/bexclude.txt ::$(hostname -s)-$(date +%Y-%m-%d,%H:%M) /Users/Olleg/Documents /Users/Olleg/Wallpaper

backup_exit=$?

info "Trimme das Repository"

# Use the `prune` subcommand to maintain 7 daily, 4 weekly and 6 monthly
# archives of THIS machine. The '{hostname}-' prefix is very important to
# limit prune's operation to this machine's archives and not apply to
# other machines' archives also:

/opt/homebrew/bin/borg prune        \
    --list                          \
    --prefix=Olivers-               \
    --show-rc                       \
    --keep-daily    7               \
    --keep-weekly   4               \
    --keep-monthly  6               \

prune_exit=$?

# use highest exit code as global exit code
global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))

if [ ${global_exit} -eq 0 ]; then
    info "Backup und Trimmen erfolgreich beendet"
elif [ ${global_exit} -eq 1 ]; then
    info "Backup und/oder Trimmen mit Warnung beendet"
else
    info "Backup und/oder Trimmen mit Fehlern beendet"
fi

exit ${global_exit}
