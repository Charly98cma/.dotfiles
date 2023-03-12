{ config, pkgs, ... }:

{
  # Enable ZSH and Oh-my-zsh
  programs.zsh = {
    enable = true;

    shellAliases = {
      "clean" = "sudo nix-collect-garbage && sudo nix-store --optimise";
      "g+++" = "g++ -Wall -Werror -Wextra -pedantic -o";
      "gccc" = "gcc -Wall -Werror -Wextra -pedantic -g -o";
      ".." = "cd ..";
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
