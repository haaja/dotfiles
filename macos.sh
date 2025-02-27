#! /bin/sh

# Dock
defaults write com.apple.dock "autohide" -bool "true"
defaults write com.apple.dock autohide-time-modifier -int "0"
defaults write com.apple.dock autohide-delay -float "0"
killall Dock

defaults write NSGlobalDomain KeyRepeat -int "2"

defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

# Finder
defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv"
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"
defaults write com.apple.finder "FXRemoveOldTrashItems" -bool "true"
killall Finder
