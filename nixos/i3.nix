{ config, pkgs, callPackage, ...}:

{
  # i3 configuration
  services.xserver = {

    enable = true;

    desktopManager = {
      xterm.enable = false;
      wallpaper = {
        combineScreens = false;
        mode = "scale";
      };
    };

    displayManager = {
      defaultSession = "none+i3";
    };

    windowManager.i3 = {
      enable = true;
      # Additional packages used to build i3
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
