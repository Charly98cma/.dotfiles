{ config, pkgs, ... }:

{
  # Configuration of additioinal Nixpkgs
  nixpkgs.config = {
    allowUnfree = true;
    #allowBroken = true;
    #allowUnsupportedSystem = true;
  };

  # List packages installed in system profile. To search, run: $ nix search wget
  environment.systemPackages = with pkgs; [
    # Essential tools
    arandr
    killall
    wget
    zip
    unzip
    escrotum
    tree
    feh
    parted

    # Development (DO NOT TOUCH UNTIL READING NIX PKGS ON DEVEL)
    gcc
    gdb

    # Dev. tools
    ripgrep	# Much faster and useful 'grep'
    coreutils
    fd		# Faster and more useful 'find'
    clang
    terminator	# Terminal
    git		# Version control tool

    # QoL Tools
    brave	# Brave internet browser
    zathura 	# PDF reader
    tdesktop 	# Telegram desktop
    slack 	# Slack client
    spotify	# Spotify client
    aspell	# Spell checker
    ranger	# File manager
    pavucontrol # Very useful audio panel
    zoom-us     # Zoom conferencing application

    # Dependencies from script/modules
    playerctl	# Command-line music controls
    zscroll	# Text scroller for panels and shells
  ];

  # Install fonts (with icons)
  fonts.fonts = with pkgs; [
   material-design-icons
   material-icons
   font-awesome
  ];
}
