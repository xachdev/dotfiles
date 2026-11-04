#!/usr/bin/env bash
set -euo pipefail
dest="$HOME/.config/sublime-text/Packages/sublime-zig"
if [ -d "$dest/.git" ]; then
  git -C "$dest" pull --ff-only
else
  mkdir -p "$(dirname "$dest")"
  git clone https://github.com/Tetralux/sublime-zig.git "$dest"
fi
