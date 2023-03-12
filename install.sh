#!/usr/bin/env bash

nix() {
  echo "nix setup..."
  #ln -is ~/.dotfiles/nixos/configuration.nix /etc/nixos/configuration.nix
  #ln -is /etc/nixos/hardware_configuration.nix ~/.dotfiles/nixos/hardware_configuration.nix
  return 0
}

dunst() {
  echo "dunst setup..."
  mkdir -p ~/.config/dunst
  ln -is ~/.dotfiles/dunst/dunstrc.conf ~/.config/dunst/dunstrc
}

zsh() {
  echo "zsh setup..."
  #ln -is ~/.dotfiles/zsh/zshrc ~/.zshrc
  return 0
}

case "$1" in
  "nix") nix;;
  "dunst") dunst;;
  "zsh") zsh;;
esac
