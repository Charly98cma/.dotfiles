
{ config, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.carlos = {
    isNormalUser = true;
    home = "/home/carlos";
    description = "Carlos Miguel";
    extraGroups = [ "wheel" "networkmanager" "video" ]; # wheel == Enable sudo
  };
}