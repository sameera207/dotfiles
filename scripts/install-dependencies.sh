#!/usr/bin/env bash
# Install essential dependencies via Homebrew

set -e

echo "Installing dependencies via Homebrew..."

# Core tools
brew install stow || echo "stow already installed"
brew install neovim || echo "neovim already installed"
brew install tmux || echo "tmux already installed"
brew install ripgrep || echo "ripgrep already installed"
brew install fzf || echo "fzf already installed"
brew install jq || echo "jq already installed"

# Install fzf keybindings
$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc

echo "✓ Dependencies installed"
