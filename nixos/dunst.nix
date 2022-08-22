{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search, run: $ nix search wget
  environment.systemPackages = with pkgs; [
    dunst
  ];
  
  systemd.user.services."dunst" = {
    enable = true;
    description = "";
    wantedBy = [ "default.target" ];
    serviceConfig.Restart = "always";
    serviceConfig.RestartSec = 2;
    serviceConfig.ExecStart = "${pkgs.dunst}/bin/dunst";
  };

}
