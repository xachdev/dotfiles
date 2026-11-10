#!/usr/bin/env bash
set -euo pipefail

if [ "$(dpkg --print-architecture)" != "amd64" ]; then
	echo "Obsidan .deb is amd64 only"
	exit 1
fi

api=https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest
json=$(curl -fsSL "$api")
tag=$(echo "$json" | jq -er '.tag_name')
ver=${tag#v}
name="obsidian_${ver}_amd64.deb"
url=$(echo "$json" | jq -er --arg n "$name" '.assets[] | select(.name == $n) | .browser_download_url')
sha=$(echo "$json" | jq -er --arg n "$name" '.assets[] | select(.name == $n) | .digest | sub("^sha256:"; "")')

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
curl -fL "$url" -o "$tmp/$name"
echo "$sha  $tmp/$name" | sha256sum -c -
sudo apt-get install -y "$tmp/$name"