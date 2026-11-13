#!/usr/bin/env bash
set -euo pipefail

mkdir -p "$HOME/.local/bin"
curl -fsSL https://starship.rs/install.sh | sh -s -- --yes --bin-dir "$HOME/.local/bin"
"$HOME/.local/bin/starship" --version
