#!/usr/bin/env bash
set -euo pipefail

if [ -x "$HOME/.cargo/bin/rustup" ]; then
  "$HOME/.cargo/bin/rustup" update stable
else
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
fi
"$HOME/.cargo/bin/rustc" --version
"$HOME/.cargo/bin/cargo" --version
