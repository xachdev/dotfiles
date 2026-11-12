#!/usr/bin/env bash
set -euo pipefail

dest="$HOME/thock"
if [ -d "$dest/.git" ]; then
git -C "$dest" pull --ff-only
else
git clone https://github.com/christophervistal25/thock "$dest"
fi
cd "$dest"
./install.sh
