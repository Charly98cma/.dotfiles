{ config, pkgs, ... }:

{
  # Enable sound and fn-keys
  hardware.pulseaudio = {
    enable = true;
    extraConfig = "
      load-module module-switch-on-connect
    ";
    package = pkgs.pulseaudioFull;
  };
  sound = {
    enable = true;
    mediaKeys = {
      enable = true;
      volumeStep = "10%";
    };
  };

  # Enable Bluetooth device
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };
}
