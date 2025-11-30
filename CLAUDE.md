# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for managing macOS development environment configuration. The repository uses symlinks to deploy configuration files from this repo to the home directory.

## Setup & Installation

### Initial Setup
Run `./symlink-setup.sh` to create symlinks for all dotfiles in the home directory. The script will:
- Symlink all dotfiles (`.bashrc`, `.zshrc`, `.vimrc`, etc.) to `~/`
- Symlink `.vim`, `bin`, and `.config` directories to `~/`
- Prompt before overwriting existing files

### Homebrew Dependencies
Install all packages with: `brew bundle`

Key packages include:
- Terminal tools: `bat`, `fd`, `ripgrep`, `jq`, `tree`, `gh`, `git-delta`
- Development: `neovim`, `mise`
- Shell: `zsh-autosuggestions`, `zsh-syntax-highlighting`, `starship` (prompt)
- Terminal: `ghostty`
- Window manager: `aerospace` (tiling window manager)

## Architecture

### Shell Configuration
- **Primary shell**: zsh (configured in `.zshrc`)
- **Prompt**: Starship (config in `.config/starship.toml`)
- **Aliases**: Defined in `.aliases` (sourced by `.zshrc`)
- **History**: Extensive history with deduplication and instant append

### Window Management
- **AeroSpace** (`.config/aerospace/aerospace.toml`): i3-like tiling window manager for macOS
  - `Alt+h/j/k/l`: Focus windows
  - `Alt+Shift+h/j/k/l`: Move windows
  - `Alt+1-9/a-z`: Switch workspaces
  - `Alt+Shift+Enter`: Fullscreen
  - `Alt+Shift+;`: Service mode (reload config, reset layout, etc.)

### Terminal
- **Ghostty**: Primary terminal emulator (config in `.config/ghostty/`)

### Git Configuration
- Config in `.gitconfig`
- Custom prompt integration via `.git-prompt.sh`
- Tab completion via `.git-completion.bash`
- Delta for diff viewing (configured via Brewfile)

## File Organization

```
.
├── .aliases            # Shell aliases (sourced by .zshrc)
├── .bash_profile       # Bash configuration
├── .bashrc             # Bash RC file
├── .dir_colors         # dircolors configuration
├── .editorconfig       # EditorConfig for consistent coding styles
├── .functions          # Shell functions
├── .gitconfig          # Git configuration
├── .gitignore          # Repository-level gitignore
├── .gitignore_global   # Global gitignore
├── .inputrc            # Readline configuration
├── .vim/               # Vim plugins and configuration
├── .vimrc              # Vim configuration
├── .zsh/               # Zsh-specific files
├── .zshenv             # Zsh environment variables
├── .zshrc              # Zsh configuration
├── .config/
│   ├── aerospace/      # AeroSpace window manager config
│   ├── ghostty/        # Ghostty terminal config
│   ├── mise/           # mise (dev tool version manager) config
│   ├── nvim/           # Neovim configuration
│   │   ├── init.lua    # Main Neovim config (using lazy.nvim)
│   │   ├── lazy-lock.json # Plugin lock file
│   │   └── colors/     # Color schemes
│   ├── starship.toml   # Starship prompt config
├── Brewfile            # Homebrew package definitions
├── symlink-setup.sh    # Symlink installation script
└── README.md           # Basic setup instructions
```

## Development Workflow

### Making Changes
1. Edit files directly in this repository
2. Changes are immediately reflected in the home directory via symlinks
3. Commit and push changes to preserve configuration

### Testing Changes
- Shell configs: Source the file (e.g., `source ~/.zshrc`)
- Vim: Restart vim or run `:source ~/.vimrc`
- Neovim: Restart nvim (lazy.nvim handles plugin updates)
- AeroSpace: Use `Alt+Shift+;` then `Esc` to reload config

### Version Management
- Node.js, Ruby, Python: Managed via `mise` (config in `.config/mise/`)

## Theme & Styling

All tools use the **Nord** color scheme for consistency:
- Vim/Neovim: `nord.vim`
- Starship: Custom Nord colors (`fg:#7b88a1`)
- Terminal: Configured in Ghostty settings
