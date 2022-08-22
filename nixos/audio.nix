{ config, pkgs, ... }:

{
  # Enable sound and fn-keys
  hardware.pulseaudio.enable = true;

  #nixpkgs.config.pulseaudio = true;

  sound = {
    enable = true;
    mediaKeys = {
      enable = true;
      volumeStep = "5%";
    };
  };
}
