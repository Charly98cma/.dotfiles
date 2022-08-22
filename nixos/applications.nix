{ config, pkgs, ... }:

{

  hardware.bluetooth.enable = true;

  # List packages installed in system profile. To search, run: $ nix search wget
  environment.systemPackages = with pkgs; [

    # Essential tools
    arandr
    killall
    wget
    htop
    zip
    unrar
    unzip
    escrotum
    tree
    feh
    gparted
    
    # Development (DO NOT TOUCH UNTIL READING NIX PKGS ON DEVEL)
    gcc
    gdb
    #jdk
    #jre

    # Dev. tools
    emacs # My do-everything-with
    terminator # Terminal
    git

    # QoL Tools
    zathura
    firefox
    tdesktop
    slack
    spotify
    #inkscape
    aspell
    ranger # File manager <- Delete if endup using rofi as FM

    # Dependencies from script/modules
    playerctl
    zscroll
  ];

}
