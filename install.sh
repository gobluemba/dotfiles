#!/bin/bash
set -e
if ! command -v node >/dev/null 2>&1; then
  curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
  sudo apt-get install -y nodejs
fi
npm install -g @anthropic-ai/claude-code
# Account-wide Claude rules: every repo opened in a Codespace inherits
# claude/standards.md (session wrap-up, parallel sessions) via the user-level
# ~/.claude/CLAUDE.md. Additive and idempotent — never overwrites existing content.
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
mkdir -p "$HOME/.claude"
cp "$DOTFILES_DIR/claude/standards.md" "$HOME/.claude/standards.md"
touch "$HOME/.claude/CLAUDE.md"
grep -qxF '@~/.claude/standards.md' "$HOME/.claude/CLAUDE.md" || printf '\n@~/.claude/standards.md\n' >> "$HOME/.claude/CLAUDE.md"
