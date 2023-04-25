#!/usr/bin/env bash

# NixOS configuration
echo "> Setting up nix..."
sudo ln -is ~/.dotfiles/nixos/configuration.nix /etc/nixos/configuration.nix
sudo ln -is /etc/nixos/hardware-configuration.nix ~/.dotfiles/nixos/hardware-configuration.nix
echo "> nix done"

# Dunst config
echo "> Setting up dunst..."
mkdir -p ~/.config/dunst
ln -is ~/.dotfiles/dunst/dunstrc.conf ~/.config/dunst/dunstrc
echo "> dunst done"

# ZSH config
echo "> Setting up zsh..."
ln -is ~/.dotfiles/zsh/zshrc ~/.zshrc
echo "> zsh done"

# Polybar config
echo "> Setting up polybar..."
cd polybar/modules/spotify/
nix-build default.nix
cd ~/.dotfiles
echo "> polybar done"

# Wallpaper
echo "> Setting up wallpaper"
ln -is ~/.dotfiles/wallpaper.png ~/.background-image
echo "> wallpaper done"
