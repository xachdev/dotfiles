#!/usr/bin/env bash
set -euo pipefail

src="$HOME/.config/obs-studio/basic"
dst="$HOME/dotfiles/obs/basic"

if pgrep -x obs >/dev/null; then
  echo "Close OBS first"
  exit 1
fi

if [ -L "$src" ]; then
  echo "Already linked: $(readlink -f "$src")"
elif [ -d "$src" ]; then
  mkdir -p "$dst"
  cp -a "$src/." "$dst/"
  mv "$src" "$src.bak"
  ln -sfn "$dst" "$src"
  echo "Moved OBS config to $dst (backup: $src.bak)"
else
  echo "No OBS config found. Open OBS once, change a setting, close it, run again."
  exit 1
fi

# Keep stream keys out of Git
cd "$HOME/dotfiles"
pat='obs/basic/profiles/*/service.json'
grep -qxF "$pat" .gitignore || echo "$pat" >> .gitignore
git rm -r --cached -q --ignore-unmatch -- "$pat"
echo "Saved. Now run: dotsync \"Save OBS config\""
