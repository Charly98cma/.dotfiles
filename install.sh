#!/usr/bin/env bash

nix() {
  echo "nix setup..."
  sudo ln -is ~/.dotfiles/nixos/configuration.nix /etc/nixos/configuration.nix
  sudo ln -is /etc/nixos/hardware-configuration.nix ~/.dotfiles/nixos/hardware-configuration.nix
}

dunst() {
  echo "dunst setup..."
  mkdir -p ~/.config/dunst
  ln -is ~/.dotfiles/dunst/dunstrc.conf ~/.config/dunst/dunstrc
}

zsh() {
  echo "zsh setup..."
  ln -is ~/.dotfiles/zsh/zshrc ~/.zshrc
}

polybar() {
  echo "polybar setup..."
  cd polybar/modules/spotify/
  nix-build default.nix
  cd ~/.dotfiles
}

wallpaper() {
  echo "wallpaper setup..."
  ln -is ~/.dotfiles/wallpaper.png ~/.background-image
}

case "$1" in
  "all") nix;dunst;zsh;polybar;wallpaper;;
  "nix") nix;;
  "dunst") dunst;;
  "zsh") zsh;;
  "polybar") polybar;;
  "wallpaper") wallpaper;;
esac
