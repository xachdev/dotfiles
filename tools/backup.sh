#!/usr/bin/env bash
set -euo pipefail

dest="${1:-}"
if [ -z "$dest" ]; then
echo "Usage: backup.sh /media/$USER/DRIVE_NAME"
exit 1
fi
if ! mountpoint -q "$dest"; then
echo "$dest is not a mounted drive"
exit 1
fi

mkdir -p "$dest/backup"
for src in "$HOME/Videos" "$HOME/projects" "$HOME/Documents/vault"; do
if [ -d "$src" ]; then
rsync -a --info=progress2 "$src" "$dest/backup/"
fi
done
echo "Backup done: $dest/backup"
