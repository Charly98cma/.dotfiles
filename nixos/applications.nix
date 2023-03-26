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
    arandr                # Screen manager
    killall               # Tool to kill all process by name
    wget
    escrotum              # Screenshot tool
    feh
    parted
    dunst                 # Notification handler

    # Dev.
    gcc
    gdb

    # Dev. tools
    ripgrep	              # Much faster and useful 'grep'
    coreutils
    fd		                # Faster and more useful 'find'
    clang
    terminator           	# Terminal
    git                   # Version control tool

    # QoL Tools
    brave	                # Brave internet browser
    zathura 	            # PDF reader
    tdesktop 	            # Telegram desktop
    slack 	              # Slack client
    spotify	              # Spotify client
    aspell	              # Spell checker
    pavucontrol           # Very useful audio panel
    zoom-us               # Zoom conferencing application
    ranger	              # File manager
    # proppler_utils        # Pdf-to-images tool

    # Dependencies from script/modules
    playerctl	            # Command-line music controls
    zscroll	              # Text scroller for panels and shells
  ];

  # Install fonts (with icons)
  fonts.fonts = with pkgs; [
   material-design-icons
   material-icons
   font-awesome
  ];
}
