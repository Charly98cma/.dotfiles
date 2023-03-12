{ config, pkgs, ... }:

{
  # Enable sound and fn-keys
  hardware.pulseaudio.enable = true;
  sound = {
    enable = true;
    mediaKeys = {
      enable = true;
      volumeStep = "10%";
    };
  };
}
