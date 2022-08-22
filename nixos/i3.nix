{ config, pkgs, callPackage, ...}:

{
  # i3 configuration
  services.xserver = {

    enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      defaultSession = "none+i3";
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        i3
        i3lock
	i3lock-color
	i3status
        polybar
        dmenu
        rofi
        lxappearance
      ];

      # Default configFile = "$HOME/.i3/config" 
      configFile = "/home/carlos/.dotfiles/i3/config";
    };
  };
}
