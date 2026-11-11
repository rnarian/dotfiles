#!/usr/bin/env bash
# Usage: ./install.sh [private]
# Links home/ into ~, installs the Brewfile(s) and the global mise tools. Safe to run again.
set -euo pipefail
cd "$(dirname "$0")"
DOTFILES=$PWD

# Link every file in home/ to ~/.<path>, e.g. home/zshrc -> ~/.zshrc.
# A real file in the way is kept as <file>.backup.
find home -type f ! -name .DS_Store | while read -r f; do
  target="$HOME/.${f#home/}"
  mkdir -p "$(dirname "$target")"
  if [ -e "$target" ] && [ ! -L "$target" ]; then mv -v "$target" "$target.backup"; fi
  ln -sfn "$DOTFILES/$f" "$target"
done

# Remove links in ~ that point to files no longer in this repo
for l in "$HOME"/.*; do
  if [ -L "$l" ] && [ ! -e "$l" ] && [[ $(readlink "$l") == "$DOTFILES"/* ]]; then rm -v "$l"; fi
done

# Homebrew packages, apps and App Store apps
[ -x /opt/homebrew/bin/brew ] || { echo "Install Homebrew first: https://brew.sh" >&2; exit 1; }
eval "$(/opt/homebrew/bin/brew shellenv)"
# A failed package doesn't stop the remaining steps; the script still fails at the end
brew bundle install --no-upgrade --file=Brewfile || failed=1
if [ "${1:-}" = private ]; then brew bundle install --no-upgrade --file=Brewfile.private || failed=1; fi

# node, pnpm, bun from home/config/mise/config.toml
mise install

if [ -n "${failed:-}" ]; then echo "Some Homebrew packages failed, see above. Fix that and run ./install.sh again." >&2; exit 1; fi
open raycast://confetti || true
