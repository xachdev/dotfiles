#!/usr/bin/env bash
set -euo pipefail
arch=$(uname -m)
case "$arch" in
  x86_64|aarch64) ;;
  *) echo "Unsupported arch: $arch"; exit 1 ;;
esac
json=$(curl -fsSL https://ziglang.org/download/index.json)
ver=$(echo "$json" | jq -r 'keys[]' | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' | sort -V | tail -1)
url=$(echo "$json" | jq -r --arg v "$ver" --arg a "$arch-linux" '.[$v][$a].tarball')
sha=$(echo "$json" | jq -r --arg v "$ver" --arg a "$arch-linux" '.[$v][$a].shasum')
dir="/opt/zig-$arch-linux-$ver"
if [ -d "$dir" ]; then
  echo "Zig $ver already installed"
else
  tmp=$(mktemp -d)
  trap 'rm -rf "$tmp"' EXIT
  curl -fL "$url" -o "$tmp/zig.tar.xz"
  echo "$sha  $tmp/zig.tar.xz" | sha256sum -c -
  sudo tar -xJf "$tmp/zig.tar.xz" -C /opt
fi
sudo ln -sfn "$dir/zig" /usr/local/bin/zig
zig version