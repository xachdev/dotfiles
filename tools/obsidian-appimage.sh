#!/usr/bin/env bash
set -euo pipefail

case "$(uname -m)" in
  x86_64)  pat='^Obsidian-[0-9.]+\.AppImage$' ;;
  aarch64) pat='^Obsidian-[0-9.]+-arm64\.AppImage$' ;;
  *) echo "Unsupported arch"; exit 1 ;;
esac

api=https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest
json=$(curl -fsSL "$api")
asset=$(echo "$json" | jq -c --arg p "$pat" '[.assets[] | select(.name | test($p))][0]')
[ "$asset" != "null" ] || { echo "AppImage not found"; exit 1; }
name=$(echo "$asset" | jq -r '.name')
url=$(echo "$asset" | jq -r '.browser_download_url')
sha=$(echo "$asset" | jq -r '.digest // empty | sub("^sha256:"; "")')

dir="$HOME/Applications/obsidian"
mkdir -p "$dir" "$HOME/.local/bin" "$HOME/.local/share/applications"
cd "$dir"
curl -fL "$url" -o "$name"
if [ -n "$sha" ]; then echo "$sha  $name" | sha256sum -c -; fi
chmod +x "$name"
rm -rf squashfs-root
"./$name" --appimage-extract > /dev/null
rm -f "$name"

printf '%s\n' '#!/usr/bin/env bash' \
  "exec \"$dir/squashfs-root/AppRun\" --no-sandbox \"\$@\"" \
  > "$HOME/.local/bin/obsidian"
chmod +x "$HOME/.local/bin/obsidian"

printf '%s\n' '[Desktop Entry]' 'Type=Application' 'Name=Obsidian' \
  "Exec=$HOME/.local/bin/obsidian %U" 'Terminal=false' 'Categories=Office;' \
  > "$HOME/.local/share/applications/obsidian.desktop"
echo "Installed: run 'obsidian'"
