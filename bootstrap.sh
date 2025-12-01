#!/bin/bash

# Bootstrap script for setting up a new macOS machine.

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_header() {
    echo -e "\n${BLUE}==>${NC} ${1}"
}

print_success() {
    echo -e "${GREEN}✓${NC} ${1}"
}

print_warning() {
    echo -e "${YELLOW}!${NC} ${1}"
}

print_error() {
    echo -e "${RED}✗${NC} ${1}"
}

ask_confirmation() {
    while true; do
        read -p "$1 (y/n) " -n 1 -r
        echo
        case $REPLY in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer y or n.";;
        esac
    done
}

# Ensure we're in the dotfiles directory
cd "$(dirname "$0")"
DOTFILES_DIR="$(pwd)"
print_success "Running from: $DOTFILES_DIR"

# Step 1: Check for Homebrew and install if needed
print_header "Checking for Homebrew..."
if ! command -v brew &> /dev/null; then
    print_warning "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
    print_success "Homebrew installed"
else
    print_success "Homebrew already installed"
fi

# Step 2: Install Homebrew packages
print_header "Installing Homebrew packages..."
if ask_confirmation "Install packages from Brewfile?"; then
    brew bundle --file="$DOTFILES_DIR/Brewfile"
    print_success "Homebrew packages installed"
else
    print_warning "Skipped Homebrew package installation"
fi

# Step 3: Set up symlinks
print_header "Setting up dotfile symlinks..."
if ask_confirmation "Create symlinks for dotfiles?"; then
    bash "$DOTFILES_DIR/symlink-setup.sh"
    print_success "Dotfile symlinks created"
else
    print_warning "Skipped symlink setup"
fi

# Step 4: Set zsh as default shell
print_header "Checking default shell..."
if [[ "$SHELL" != */zsh ]]; then
    print_warning "Current shell is not zsh"
    if ask_confirmation "Set zsh as default shell?"; then
        chsh -s "$(which zsh)"
        print_success "Default shell changed to zsh (restart terminal to apply)"
    fi
else
    print_success "Default shell is already zsh"
fi

# Step 5: Install mise tools
print_header "Setting up mise tools..."
if command -v mise &> /dev/null; then
    # Activate mise for this script
    eval "$(mise activate bash)"

    if ask_confirmation "Install mise tools (Ruby, Node, Python)?"; then
        mise install
        print_success "mise tools installed"

        # Show installed versions
        echo -e "\nInstalled versions:"
        mise list
    else
        print_warning "Skipped mise tool installation"
    fi
else
    print_warning "mise not found. Install Homebrew packages first."
fi

# Final summary
print_header "Bootstrap complete!"
echo -e "
${GREEN}✓${NC} Setup completed successfully!

Restart your terminal or run: ${BLUE}source ~/.zshrc${NC}

${YELLOW}Optional next steps:${NC}
- Set up git user config: ${BLUE}git config --global user.name \"Your Name\"${NC}
- Set up git user email: ${BLUE}git config --global user.email \"your@email.com\"${NC}
"
