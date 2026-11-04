#!/usr/bin/env bash
set -euo pipefail
if command -v subl >/dev/null; then
  echo "Sublime Text already installed"
  exit 0
fi
sudo install -d -m 0755 /etc/apt/keyrings
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg \
  | sudo tee /etc/apt/keyrings/sublimehq-pub.asc > /dev/null
printf '%s\n' 'Types: deb' 'URIs: https://download.sublimetext.com/' \
  'Suites: apt/stable/' 'Signed-By: /etc/apt/keyrings/sublimehq-pub.asc' \
  | sudo tee /etc/apt/sources.list.d/sublime-text.sources > /dev/null
sudo apt-get update
sudo apt-get install -y sublime-text