#!/usr/bin/env bash
set -euo pipefail

font="${1:-JetBrainsMono}"
size=14
dir="$HOME/.local/share/fonts/${font}NerdFont"
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

mkdir -p "$dir"
curl -fL "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${font}.tar.xz" -o "$tmp/font.tar.xz"
tar -xJf "$tmp/font.tar.xz" -C "$dir"
fc-cache -f "$dir"

rc="$HOME/.config/xfce4/terminal/terminalrc"
mkdir -p "$(dirname "$rc")"
[ -f "$rc" ] || echo "[Configuration]" > "$rc"

setkey() {
  if grep -q "^$1=" "$rc"; then
    sed -i "s|^$1=.*|$1=$2|" "$rc"
  else
    echo "$1=$2" >> "$rc"
  fi
}
setkey FontUseSystem FALSE
setkey FontName "${font} Nerd Font Mono ${size}"

echo "Done. Close and reopen the terminal."
