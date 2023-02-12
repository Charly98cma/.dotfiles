# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
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

  # Use the systemd-boot EFI boot loader.
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

  # Default terminal
  environment.variables.EDITOR = "terminator";

  # Set your time zone.
  time.timeZone = "Europe/Madrid";


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.carlos = {
    isNormalUser = true;
    home = "/home/carlos";
    description = "Carlos Miguel";
    extraGroups = [ "wheel" "networkmanager" ]; # wheel == Enable ‘sudo’ for the user.
  };


  # Pick only one of the below networking options.
  networking = {
    hostName = "Nix-OsMachina"; # Define your hostname.
    networkmanager.enable = true;  # Easiest to use and most distros use this by default.
    useDHCP = false;
    interfaces.wlo1.useDHCP = true;    
  };  

  # Install fonts
  fonts.fonts = with pkgs; [
    material-design-icons
    material-icons
    font-awesome
  ];

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = true;

  nixpkgs.config = {
    allowUnfree = true;
    #allowBroken = true;
    #allowUnsupportedSystem = true;
  };

  # Systemd config (related to power management)
  services.logind.extraConfig = ''
    # Don’t shutdown when power button is short-pressed
    HandlePowerKey=ignore
    # Ignore lid switch to close laptop without suspend
    HandleLidSwitch=ignore
  '';
  
  # Configure keymap in X11
  services.xserver.layout = "es";
  services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Cleaning and optimising
  nix = {
    gc.automatic = true;
    settings.auto-optimise-store = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}