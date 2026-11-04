#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"

for f in bashrc gitconfig nanorc tmux.conf gitgnore_global vimrc; do
	[ -e "$HOME/.$f" ] && [ ! -L "$HOME/.$f" ] && mv "$HOME/.$f" "$HOME/.$f.bak"
	ln -sf "$PWD/$f" "$HOME/.$f"
	echo "linked .$f"
done

# Sublime Text settings
SUBL="$HOME/.config/sublime-text/Packages/User"
mkdir -p "$SUBL"
for f in "Preferences.sublime-settings" "Package Control.sublime-settings"; do
  ln -sf "$PWD/sublime/$f" "$SUBL/$f"
done
