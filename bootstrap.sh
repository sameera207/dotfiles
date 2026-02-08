#!/usr/bin/env bash
# Dotfiles installation script

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Dotfiles Installation ===${NC}\n"

# Get the directory where this script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Function to prompt for user input
prompt_user_info() {
    echo -e "${BLUE}=== Personal Configuration Setup ===${NC}\n"

    # Git configuration
    read -p "Enter your full name (for Git commits): " git_name
    read -p "Enter your email address (for Git): " git_email
    read -p "Enter your GitHub username: " github_username

    # JIRA configuration (optional)
    read -p "Enter your JIRA workspace name (e.g., 'mycompany' for mycompany.atlassian.net) [optional]: " jira_workspace

    echo -e "\n${GREEN}Configuration received:${NC}"
    echo -e "  Name: $git_name"
    echo -e "  Email: $git_email"
    echo -e "  GitHub: $github_username"
    [ -n "$jira_workspace" ] && echo -e "  JIRA: $jira_workspace.atlassian.net"
    echo ""
    read -p "Is this correct? (y/n): " confirm

    if [[ $confirm != [yY] ]]; then
        echo -e "${YELLOW}Please run the script again with correct information${NC}"
        exit 1
    fi
}

# Function to generate config from template
generate_gitconfig() {
    local template="$DOTFILES_DIR/git/.gitconfig.example"
    local output="$DOTFILES_DIR/git/.gitconfig"

    if [ ! -f "$template" ]; then
        echo -e "${RED}Error: $template not found${NC}"
        return 1
    fi

    echo -e "${BLUE}Generating .gitconfig from template...${NC}"
    cp "$template" "$output"

    # macOS sed requires '' after -i
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s/{{GIT_NAME}}/$git_name/g" "$output"
        sed -i '' "s/{{GIT_EMAIL}}/$git_email/g" "$output"
    else
        sed -i "s/{{GIT_NAME}}/$git_name/g" "$output"
        sed -i "s/{{GIT_EMAIL}}/$git_email/g" "$output"
    fi

    echo -e "${GREEN}✓ .gitconfig generated${NC}"
}

# Function to generate private.zsh from template
generate_private_zsh() {
    local template="$HOME/.config/zsh/private.zsh.example"
    local output="$HOME/.config/zsh/private.zsh"

    if [ -f "$output" ]; then
        echo -e "${YELLOW}private.zsh already exists, skipping...${NC}"
        return 0
    fi

    echo -e "${BLUE}Creating private.zsh from template...${NC}"
    cp "$template" "$output"

    # Replace placeholders if JIRA workspace was provided
    if [ -n "$jira_workspace" ]; then
        if [[ "$OSTYPE" == "darwin"* ]]; then
            sed -i '' "s/{{JIRA_WORKSPACE}}/$jira_workspace/g" "$output"
            sed -i '' "s/{{YOUR_EMAIL}}/$git_email/g" "$output"
        else
            sed -i "s/{{JIRA_WORKSPACE}}/$jira_workspace/g" "$output"
            sed -i "s/{{YOUR_EMAIL}}/$git_email/g" "$output"
        fi
    fi

    echo -e "${GREEN}✓ private.zsh created${NC}"
    echo -e "${RED}⚠️  IMPORTANT: Edit ~/.config/zsh/private.zsh with your API tokens${NC}"
}

# Prompt for user information at the start
prompt_user_info

# Generate configs from templates
generate_gitconfig

# Check for Homebrew
if ! command -v brew &> /dev/null; then
    echo -e "${BLUE}Installing Homebrew...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon
    if [[ $(uname -m) == 'arm64' ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo -e "${GREEN}✓ Homebrew already installed${NC}"
fi

# Install GNU Stow
if ! command -v stow &> /dev/null; then
    echo -e "${BLUE}Installing GNU Stow...${NC}"
    brew install stow
else
    echo -e "${GREEN}✓ GNU Stow already installed${NC}"
fi

# Install dependencies
echo -e "\n${BLUE}Installing dependencies...${NC}"
bash "$DOTFILES_DIR/scripts/install-dependencies.sh"

# Install Oh My Zsh
echo -e "\n${BLUE}Checking Oh My Zsh installation...${NC}"
bash "$DOTFILES_DIR/scripts/install-omz.sh"

# Install asdf
echo -e "\n${BLUE}Checking asdf installation...${NC}"
bash "$DOTFILES_DIR/scripts/install-asdf.sh"

# Install TPM
echo -e "\n${BLUE}Checking Tmux Plugin Manager installation...${NC}"
bash "$DOTFILES_DIR/scripts/install-tpm.sh"

# Stow configurations
echo -e "\n${BLUE}Linking dotfiles with GNU Stow...${NC}"

# Backup existing configs if they exist and are not symlinks
backup_if_exists() {
    local file=$1
    if [ -e "$file" ] && [ ! -L "$file" ]; then
        echo -e "${YELLOW}Backing up existing $file to $file.backup${NC}"
        mv "$file" "$file.backup"
    fi
}

backup_if_exists "$HOME/.zshrc"
backup_if_exists "$HOME/.zprofile"
backup_if_exists "$HOME/.bashrc"
backup_if_exists "$HOME/.bash_profile"
backup_if_exists "$HOME/.gitconfig"
backup_if_exists "$HOME/.tmux.conf"

# Stow all packages
cd "$DOTFILES_DIR"
stow -v -t "$HOME" zsh
stow -v -t "$HOME" bash
stow -v -t "$HOME" git
stow -v -t "$HOME" nvim
stow -v -t "$HOME" tmux
stow -v -t "$HOME" asdf

echo -e "${GREEN}✓ Dotfiles linked${NC}"

# Generate private.zsh from template (if it doesn't exist)
generate_private_zsh

# Install vim-plug if not already installed
if [ ! -f "${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site/autoload/plug.vim" ]; then
    echo -e "\n${BLUE}Installing vim-plug...${NC}"
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

# Install Neovim plugins
echo -e "\n${BLUE}Installing Neovim plugins (this may take a few minutes)...${NC}"
nvim --headless +PlugInstall +qall 2>&1 | grep -v "^$" || echo "Plugins installed"

# Install Tmux plugins
if [ -d "$HOME/.tmux/plugins/tpm" ]; then
    echo -e "\n${BLUE}Installing Tmux plugins...${NC}"
    bash "$HOME/.tmux/plugins/tpm/bin/install_plugins"
fi

# Install asdf plugins and tools
if [ -f "$HOME/.tool-versions" ]; then
    echo -e "\n${BLUE}Setting up asdf tools...${NC}"

    # Source asdf
    . "$HOME/.asdf/asdf.sh"

    # Install plugins
    asdf plugin add ruby 2>/dev/null || echo "Ruby plugin already added"
    asdf plugin add nodejs 2>/dev/null || echo "Node.js plugin already added"
    asdf plugin add kubectl 2>/dev/null || echo "kubectl plugin already added"

    # Install tools
    echo -e "${BLUE}Installing tools from .tool-versions (this may take several minutes)...${NC}"
    asdf install
fi

echo -e "\n${GREEN}========================================${NC}"
echo -e "${GREEN}✓ Installation complete!${NC}"
echo -e "${GREEN}========================================${NC}"

echo -e "\n${BLUE}Next steps:${NC}"
echo -e "1. Edit ${YELLOW}~/.config/zsh/private.zsh${NC} with your API tokens"
echo -e "2. Restart your shell: ${YELLOW}exec zsh${NC}"
echo -e "3. Verify Neovim: ${YELLOW}nvim +PlugStatus${NC}"
echo -e "4. In tmux, press ${YELLOW}prefix + I${NC} to ensure all plugins are loaded"
echo -e "\n${BLUE}Note:${NC} Your original configs have been backed up with .backup extension"
