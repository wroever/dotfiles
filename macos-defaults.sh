#!/bin/bash

# Apply the small set of currently verified non-default macOS preferences
# for this machine. Safe to re-run: each command overwrites the target
# preference.

set -e

if [[ "$(uname)" != "Darwin" ]]; then
    echo "This script only supports macOS."
    exit 1
fi

# Trackpad / mouse
# Disable "natural" scrolling so content follows the scroll wheel direction.
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
defaults write NSGlobalDomain com.apple.mouse.scaling -float 3
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 3

# Keyboard
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain KeyRepeat -int 2

# Finder
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Dock / Mission Control
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock mru-spaces -bool false
defaults write com.apple.dock tilesize -int 31

killall Dock >/dev/null 2>&1 || true

echo "Applied macOS preferences."
echo "Some changes may require logging out or restarting affected apps."
