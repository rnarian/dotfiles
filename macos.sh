#!/usr/bin/env bash
# macOS settings. Not run by install.sh, run it by hand: ./macos.sh
# Some settings only apply after logging out and in again.
set -euo pipefail

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Disable smart quotes and dashes as they're annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Trackpad: tap to click (built-in and Magic Trackpad)
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 1

# Trackpad: faster cursor
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 3

# Keyboard: key repeat instead of press-and-hold, fast repeat, short delay
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
