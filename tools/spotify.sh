#!/usr/bin/env bash
set -euo pipefail

if [ "$(dpkg --print-architecture)" != "amd64" ]; then
  echo "Spotify repository is amd64 only"
  exit 1
fi
if ! dpkg --compare-versions "$(dpkg-query -W -f "\${Version}" libc6)" ge 2.39; then
  echo "Spotify needs glibc 2.39+ (Ubuntu 24.04 or newer)."
  exit 1
fi

curl -fsSL https://download.spotify.com/debian/pubkey_5384CE82BA52C83A.asc \
  | sudo gpg --dearmor --yes -o /usr/share/keyrings/spotify-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/spotify-archive-keyring.gpg] https://repository.spotify.com stable non-free" \
  | sudo tee /etc/apt/sources.list.d/spotify.list > /dev/null
sudo apt-get update
sudo apt-get install -y spotify-client
