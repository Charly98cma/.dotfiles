{ config, pkgs, ... }:

{
  networking = {
    hostName = "NixOsMachina";
    networkmanager.enable = true;
    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
    interfaces.wlo1.useDHCP = true;
  };

  # Enable NetworkManager applet
  programs.nm-applet.enable = true;
}
