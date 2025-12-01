# Dotfiles

These are my dotfiles. There are many like them but these ones are mine.

## Quick Setup

For a complete setup on a fresh macOS machine, run `./bootstrap.sh`.

The bootstrap script will:
- Install Homebrew (if needed)
- Install all packages from Brewfile
- Create symlinks for dotfiles
- Optionally install mise tools

## Manual Setup

If you prefer to set up components individually:

1. Create symlinks: `./symlink-setup.sh`
2. Install Homebrew packages: `brew bundle`
3. Install mise tools: `mise install`
