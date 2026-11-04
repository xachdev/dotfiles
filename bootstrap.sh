#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"

echo "==> Setting up Sublime Text repository..."
# Add Sublime Text GPG key and repository (using the modern non-deprecated method)
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/keyrings/sublimetext.gpg > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/sublimetext.gpg] https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

echo "==> Updating package lists..."
sudo apt update

echo "==> Installing standard packages from packages.txt..."
xargs -a packages.txt sudo apt install -y

echo "==> Installing Sublime Text..."
sudo apt install -y sublime-text

echo "==> Symlinking dotfiles and Sublime settings..."
./install.shtools/sublime.sh
tools/zig.sh
