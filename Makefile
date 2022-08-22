
# Move to Bash file

.ONESHELL:
nix:
	ln -s ~/.dotfiles/nios/configuration.nix /etc/nixos/configuration.nix

.ONESHELL:
dunst:
	mkdir -p ~/.config/dunst/dunstrc
	ln -s ~/.dotfiles/dunst/dunstrc.conf ~/.config/dunst/dunstrc

.ONESHELL:
zsh:
	ln -s ~/.dotfiles7zsh/zshrc ~/.zshrc
