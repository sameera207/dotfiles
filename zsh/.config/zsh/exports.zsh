# Environment Variables and PATH Configuration

# Python
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="$PATH:$HOME/.gem/ruby/3.3.0/bin"

# Local binaries
export PATH="$PATH:$HOME/.local/bin"

# PostgreSQL
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

# asdf
export PATH="$HOME/.asdf/shims:$PATH"

# qlty
export QLTY_INSTALL="$HOME/.qlty"
export PATH="$QLTY_INSTALL/bin:$PATH"

# qlty completions
[ -s "/opt/homebrew/share/zsh/site-functions/_qlty" ] && source "/opt/homebrew/share/zsh/site-functions/_qlty"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
