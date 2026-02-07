#!/usr/bin/env bash
# Install Tmux Plugin Manager

set -e

if [ -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "TPM already installed, skipping..."
    exit 0
fi

echo "Installing Tmux Plugin Manager..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "✓ TPM installed"
echo "Note: After starting tmux, press prefix + I to install plugins"
