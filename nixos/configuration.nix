{ config, pkgs, ... }:

{
  # Import configuration from other Nix files
  imports =
    [
      ./actkbd.nix
      ./applications.nix
      ./audio.nix
      ./dunst.nix
      ./emacs.nix
      ./hardware-configuration.nix
      ./i3.nix
      ./light.nix
      ./network-config.nix
      ./polybar.nix
      ./printing.nix
      ./ssh.nix
      ./touchpad.nix
      ./users.nix
      ./zsh.nix
    ];

  # Boot and EFI configuration
  boot = {
    # Hibernate (to swap partition)
    resumeDevice = "/dev/nvme0n1p5";
    # Keep '/tmp' clean
    cleanTmpDir = true;
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
	# Max. number of profiles
        configurationLimit = 3;
      };
      efi = {
        canTouchEfiVariables = true;
      };
      timeout = 10;
    };
    # Always get latest
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # Cleaning and optimising Nix system
  nix = {
    gc.automatic = true;
    settings.auto-optimise-store = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Default terminal
  environment.variables.EDITOR = "terminator";

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
