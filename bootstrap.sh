#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"
sudo apt update
xargs -a packages.txt sudo apt install -y
./install.sh
