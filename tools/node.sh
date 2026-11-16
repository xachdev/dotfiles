#!/usr/bin/env bash
set -eo pipefail

export NVM_DIR="$HOME/.nvm"
if [ ! -s "$NVM_DIR/nvm.sh" ]; then
  tag=$(curl -fsSL https://api.github.com/repos/nvm-sh/nvm/releases/latest | jq -er '.tag_name')
  curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/${tag}/install.sh" | PROFILE=/dev/null bash
fi

# shellcheck disable=SC1091
. "$NVM_DIR/nvm.sh"
nvm install --lts
nvm alias default 'lts/*'
node --version
npm --version
