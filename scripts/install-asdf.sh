#!/usr/bin/env bash
# Install asdf version manager

set -e

if [ -d "$HOME/.asdf" ]; then
    echo "asdf already installed, skipping..."
    exit 0
fi

echo "Installing asdf..."
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1

# Source asdf for current session
. "$HOME/.asdf/asdf.sh"

echo "✓ asdf installed"
