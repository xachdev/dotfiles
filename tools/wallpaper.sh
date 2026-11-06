#!/usr/bin/env bash
set -euo pipefail

img="${1:-$(find "$HOME/dotfiles/wallpapers" -name 'wallpaper.*' | head -1)}"
[ -f "$img" ] || { echo "No image found"; exit 1; }
command -v xfconf-query >/dev/null || { echo "xfconf-query not found (XFCE only)"; exit 1; }

props=$(xfconf-query -c xfce4-desktop -l | grep 'last-image$' || true)
[ -n "$props" ] || { echo "Set any wallpaper once in Settings > Desktop first"; exit 1; }

while read -r p; do
	xfconf-query -c xfce4-desktop -p "$p" -s "$img"
	xfconf-query -c xfce4-desktop -p "${p%last-image}image-style" -s 5 || true
done <<< "$props"
echo "Wallpaper set: $img"