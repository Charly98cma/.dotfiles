{ config, pkgs, ... }:

{
  # Enable ZSH and Oh-my-zsh
  programs.zsh = {
    enable = true;

    shellAliases = {
      "upd-rb" = "sudo nix-rebuild switch --rollback";
      "upd-cln" = "sudo nix-collect-garbage && sudo nix-store --optimise";
      "upd" = "sudo nixos-rebuild boot --upgrade";
      "upd-sw" = "sudo nixos-rebuild switch --upgrade";
      "g+++" = "g++ -Wall -Werror -pedantic -o";
      "gccc" = "gcc -Wall -Werror -pedantic -g -o";
      ".." = "cd ..";
      #apod="make -C /home/carlos/.dotfiles/.i3/wallpaper/APOD-Wallpaper/ run";
    };

    autosuggestions.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    ohMyZsh = {
      enable = true;
      plugins = [ "git" "git-extras" "pip" "pyenv" "sudo" "docker" ];
      theme = "fino";
    };

  };

  environment.pathsToLink = [ "/share/zsh" ];

  users.defaultUserShell = pkgs.zsh;
}
