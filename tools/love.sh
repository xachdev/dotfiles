#!/usr/bin/env bash
set -euo pipefail

if [ "$(uname -m)" != "x86_64" ]; then
  echo "LOVE AppImage is x86_64 only"
  exit 1
fi

api=https://api.github.com/repos/love2d/love/releases/latest
json=$(curl -fsSL "$api")
asset=$(echo "$json" | jq -c '[.assets[] | select(.name | test("^love-.*-x86_64\\.AppImage$"))][0]')
if [ "$asset" = "null" ]; then
  echo "AppImage not found in the latest release"
  exit 1
fi
name=$(echo "$asset" | jq -r '.name')
url=$(echo "$asset" | jq -r '.browser_download_url')
sha=$(echo "$asset" | jq -r '.digest // empty | sub("^sha256:"; "")')

dir="$HOME/Applications/love"
mkdir -p "$dir" "$HOME/.local/bin"
cd "$dir"
curl -fL "$url" -o "$name"
if [ -n "$sha" ]; then echo "$sha  $name" | sha256sum -c -; fi
chmod +x "$name"
rm -rf squashfs-root
"./$name" --appimage-extract > /dev/null
rm -f "$name"

printf '%s\n' '#!/usr/bin/env bash' \
  "exec \"$dir/squashfs-root/AppRun\" \"\$@\"" \
  > "$HOME/.local/bin/love"
chmod +x "$HOME/.local/bin/love"
"$HOME/.local/bin/love" --version
