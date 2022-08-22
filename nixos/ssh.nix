{ config, pkgs, ... }:

{
  programs.ssh = {

    enable = true;
    forwardX11 = true;
    startAgent = true;

    extraConfig = "
      Host triqui1
        Hostname triqui1.fi.upm.es
	User z170243
    "
  };
}