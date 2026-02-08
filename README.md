# Dotfiles

Personal dotfiles for macOS, managed with GNU Stow. Includes configurations for Neovim, Tmux, Zsh, and development tools.

## Features

- **Shell**: Zsh with Oh My Zsh (robbyrussell theme)
- **Editor**: Neovim with 52 plugins via vim-plug
  - LSP support (coc.nvim)
  - AI integration (GitHub Copilot, CopilotChat, Claude Code)
  - Language support (Ruby, Elixir, TypeScript, JavaScript)
- **Terminal Multiplexer**: Tmux with TPM (Tmux Plugin Manager)
- **Version Manager**: asdf (Ruby 3.3.6, Node.js 20.18.0, kubectl 1.32.0)
- **Git**: Custom configuration and global ignores
- **Modular Shell Config**: Separate files for exports, aliases, functions, and private secrets

## Quick Start

```bash
# Clone the repository (replace YOUR_USERNAME with your GitHub username)
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles

# Run the bootstrap script
cd ~/dotfiles
./bootstrap.sh
```

The bootstrap script will:
1. **Prompt for your personal information** (name, email, GitHub username, JIRA workspace)
2. Generate your `.gitconfig` from template
3. Install Homebrew (if not present)
4. Install GNU Stow
5. Install dependencies (neovim, tmux, ripgrep, fzf, jq)
6. Install Oh My Zsh, asdf, and TPM
7. Create symlinks for all configurations
8. Create a `private.zsh` file with your information
9. Install Neovim plugins (52 plugins via vim-plug)
10. Install Tmux plugins
11. Install asdf tools (Ruby, Node.js, kubectl)

### First-Time Setup

When you run `./bootstrap.sh`, you'll be prompted for:
- **Full name** - Used for Git commits
- **Email address** - Used for Git commits and JIRA
- **GitHub username** - Your GitHub handle
- **JIRA workspace** (optional) - Your company's Jira workspace name

These values are used to generate your personal `.gitconfig` and pre-fill your `private.zsh` file.

## Prerequisites

- macOS (tested on macOS 13+)
- Git
- Internet connection

## Manual Installation (Selective)

You can also install specific components individually:

```bash
# Install only shell configuration
stow zsh

# Install only Neovim
stow nvim

# Install multiple components
stow zsh git nvim tmux asdf
```

## Directory Structure

```
dotfiles/
├── bootstrap.sh              # Main installation script
├── README.md                 # This file
├── .gitignore               # Protects secrets from being committed
├── zsh/                     # Zsh configuration
│   ├── .zshrc              # Main zsh config
│   ├── .zprofile           # Zsh profile
│   └── .config/zsh/
│       ├── exports.zsh     # Environment variables
│       ├── aliases.zsh     # Shell aliases
│       ├── functions.zsh   # Custom functions
│       └── private.zsh.example  # Template for secrets
├── bash/                    # Bash configuration (fallback)
│   ├── .bashrc
│   └── .bash_profile
├── git/                     # Git configuration
│   ├── .gitconfig.example  # Template (generated on setup)
│   └── .config/git/ignore
├── nvim/                    # Neovim configuration
│   └── .config/nvim/
│       ├── init.vim
│       ├── lua/
│       └── README.md
├── tmux/                    # Tmux configuration
│   ├── .tmux.conf
│   └── .config/tmuxinator/
├── asdf/                    # asdf tool versions
│   └── .tool-versions
└── scripts/                 # Installation helper scripts
    ├── install-dependencies.sh
    ├── install-omz.sh
    ├── install-asdf.sh
    └── install-tpm.sh
```

## Secrets Management

⚠️ **IMPORTANT**: Never commit secrets to git!

Sensitive data (API tokens, credentials) should be stored in `~/.config/zsh/private.zsh`, which is automatically created from the template and gitignored.

### Setup Private Configuration

1. After running bootstrap, edit the private config:
   ```bash
   nvim ~/.config/zsh/private.zsh
   ```

2. Add your secrets:
   ```bash
   # JIRA/Atlassian API Configuration
   export JIRA_URL="https://your-domain.atlassian.net"
   export JIRA_USERNAME="your-email@example.com"
   export JIRA_API_TOKEN="your-actual-token"

   # GitHub Personal Access Token
   export GITHUB_PERSONAL_ACCESS_TOKEN="your-github-token"

   # Other secrets
   export QLTY_COVERAGE_TOKEN="your-token"
   ```

3. Restart your shell:
   ```bash
   exec zsh
   ```

## Post-Installation

### 1. Verify Shell Configuration
```bash
echo $ZSH_THEME  # Should output: robbyrussell
which python     # Should point to python3
```

### 2. Verify Neovim Plugins
```bash
nvim +PlugStatus
```
All 52 plugins should show as installed.

### 3. Verify Tmux Plugins
```bash
tmux
# Press prefix (Ctrl+b) + I to install plugins
# Press prefix + U to update plugins
```

### 4. Verify asdf Tools
```bash
asdf current
# ruby      3.3.6
# nodejs    20.18.0
# kubectl   1.32.0
```

### 5. Verify Git Configuration
```bash
git config --global user.name    # Should output your name
git config --global user.email   # Should output your email
```

## Uninstalling

To remove symlinks:

```bash
cd ~/dotfiles
stow -D zsh bash git nvim tmux asdf
```

This will only remove the symlinks, not your actual configuration files.

## Updating

To update your dotfiles:

```bash
cd ~/dotfiles
git pull
stow -R zsh git nvim tmux  # Restow to update symlinks
```

## Customization

### Adding New Aliases
Edit `~/.config/zsh/aliases.zsh` and commit changes:
```bash
echo 'alias gs="git status"' >> ~/.config/zsh/aliases.zsh
cd ~/dotfiles
git add zsh/.config/zsh/aliases.zsh
git commit -m "Add git status alias"
```

### Adding New Plugins to Neovim
Edit `~/dotfiles/nvim/.config/nvim/init.vim`, add plugin, then:
```bash
nvim +PlugInstall +qall
cd ~/dotfiles
git add nvim/.config/nvim/init.vim
git commit -m "Add new neovim plugin"
```

## Backup Strategy

The bootstrap script automatically backs up existing configurations with a `.backup` extension before creating symlinks. These backups are preserved and not tracked in git.

## Dependencies Installed

via Homebrew:
- GNU Stow (symlink manager)
- Neovim (text editor)
- Tmux (terminal multiplexer)
- Ripgrep (fast grep alternative)
- fzf (fuzzy finder)
- jq (JSON processor)

via Scripts:
- Oh My Zsh (Zsh framework)
- asdf (version manager)
- TPM (Tmux Plugin Manager)
- vim-plug (Neovim plugin manager)

## Troubleshooting

### "Conflicts" when running stow
If you get conflicts, it means existing files are not symlinks. Back them up:
```bash
mv ~/.zshrc ~/.zshrc.backup
stow zsh
```

### Neovim plugins not loading
Reinstall plugins:
```bash
nvim +PlugClean +PlugInstall +qall
```

### Tmux plugins not working
Reinstall TPM plugins:
```bash
~/.tmux/plugins/tpm/bin/install_plugins
```

### Shell can't find commands
Make sure to restart your shell after installation:
```bash
exec zsh
```

## Platform

- Tested on macOS 13+ (Ventura and later)
- Supports both Intel and Apple Silicon Macs

## Notes

- **Oh My Zsh**: Installed separately via script, not tracked in git
- **asdf**: Installed separately, only `.tool-versions` is tracked
- **Neovim plugins**: Auto-installed via vim-plug (not in git, ~205MB)
- **Tmux plugins**: Auto-installed via TPM (not in git)
- **LazyVim starter**: Excluded (unused template)

## Contributing

This is a personal dotfiles repository, but feel free to fork it and adapt it for your own use!

## License

MIT

## Portability

These dotfiles are fully portable and contain **no hardcoded paths or personal information**:

- All paths use `$HOME` or `~` expansion
- Git configuration generated from template on first run
- Personal information never committed to repository
- Works across different machines and users

### Template System

Personal information is managed via templates:
- `git/.gitconfig.example` → generates `git/.gitconfig` (gitignored)
- `zsh/.config/zsh/private.zsh.example` → generates `private.zsh` (gitignored)

The bootstrap script prompts for your information and fills in the templates automatically.

## Author

Originally created by Sameera (Sam)
