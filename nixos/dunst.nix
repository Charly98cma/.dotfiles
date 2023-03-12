{ config, pkgs, ... }:

{
  # Include 'dunst' in packages to install
  environment.systemPackages = with pkgs; [
    dunst
  ];
  
  # Dunst configuration
  systemd.user.services."dunst" = {
    enable = true;
    description = "Dunst (notification manager)";
    wantedBy = [ "default.target" ];
    serviceConfig.Restart = "always";
    serviceConfig.RestartSec = 2;
    serviceConfig.ExecStart = "${pkgs.dunst}/bin/dunst";
  };

}
