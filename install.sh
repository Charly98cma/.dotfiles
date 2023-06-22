#!/usr/bin/env bash

# NixOS configuration
echo "> Setting up nix..."
sudo ln -is ~/.dotfiles/nixos/configuration.nix /etc/nixos/configuration.nix || echo \n">> 'ln' failed" && exit 1
sudo ln -is /etc/nixos/hardware-configuration.nix ~/.dotfiles/nixos/hardware-configuration.nix || echo "\n>> 'ln' failed" && exit 1
echo "> nix done"

# Dunst config
echo "> Setting up dunst..."
mkdir -p ~/.config/dunst || echo "\n>> 'mkdir' failed" && exit 1
ln -is ~/.dotfiles/dunst/dunstrc.conf ~/.config/dunst/dunstrc || echo "\n>> 'ln' failed" && exit 1
echo "> dunst done"

# ZSH config
echo "> Setting up zsh..."
ln -is ~/.dotfiles/zsh/zshrc ~/.zshrc || echo "\n>> 'ln' failed" && exit 1
echo "> zsh done"

# Polybar config
echo "> Setting up polybar..."
cd polybar/modules/spotify/
nix-build default.nix || echo "\n>> 'nix-build' Failed" && exit 1
cd ../../..
echo "> polybar done"

# Wallpaper
echo "> Setting up wallpaper"
ln -is ~/.dotfiles/wallpaper.png ~/.background-image || echo "\n>> 'ln' failed" && exit 1
echo "> wallpaper done"

# Install new system
sudo nixos-rebuild boot --upgrade
if [[ $? -eq 0 ]]; then reboot; else echo "\n> 'nixos-rebuild' failed"; fi
