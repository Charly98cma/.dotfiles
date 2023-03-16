{ config, pkgs, ... }:

{
  services = {
    # Enable CUPS to print documents.
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns = true;
      # for a WiFi printer
      openFirewall = true;
    };
  };
}