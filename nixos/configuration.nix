# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix # Hardware scan
      ./users.nix
      ./network-config.nix
      ./applications.nix
      ./light.nix
      ./touchpad.nix
      ./i3.nix
      ./audio.nix
      ./zsh.nix
      ./polybar.nix
      ./actkbd.nix
      ./dunst.nix
    ];

  nixpkgs.config = {
    allowUnfree = true;
    #allowBroken = true;
    #allowUnsupportedSystem = true;
  };

  # EFI things
  boot = {
    cleanTmpDir = true;
    loader = {      
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 3;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  # Systemd config (related to power management)
  services.logind.extraConfig = ''
    # Don’t shutdown when power button is short-pressed
    HandlePowerKey=ignore
    # Ignore lid switch to close laptop without suspend
    HandleLidSwitch=ignore
  '';
  
  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Configure keymap in X11
  services.xserver.layout = "es";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Install fonts
  fonts.fonts = with pkgs; [
    material-design-icons
    material-icons
    font-awesome-ttf
  ];

  # Cleaning and optimising
  nix = {
    gc.automatic = true;
    autoOptimiseStore = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}
