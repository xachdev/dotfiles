#!/usr/bin/env bash
set -euo pipefail

if [ "$(dpkg --print-architecture)" != "amd64" ]; then
  echo "Mechvibes DX .deb is amd64 only"
  exit 1
fi

api=https://api.github.com/repos/hainguyents13/mechvibes-dx/releases/latest
json=$(curl -fsSL "$api")
deb_url=$(echo "$json" | jq -r '.assets[] | select(.name | endswith("amd64.deb")) | .browser_download_url' | head -1)
sums_url=$(echo "$json" | jq -r '.assets[] | select(.name == "SHA256SUMS.txt") | .browser_download_url' | head -1)
[ -n "$deb_url" ] && [ -n "$sums_url" ] || { echo "Release assets not found"; exit 1; }

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
name=$(basename "$deb_url")
curl -fL "$deb_url" -o "$tmp/$name"
curl -fL "$sums_url" -o "$tmp/SHA256SUMS.txt"
(cd "$tmp" && grep -F "$name" SHA256SUMS.txt | sha256sum -c -)

sudo apt-get install -y "$tmp/$name"
sudo usermod -aG input "$USER"
echo "Done. Log out and back in, or Mechvibes won't see key presses."
