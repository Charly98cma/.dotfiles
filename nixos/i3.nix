{ config, pkgs, callPackage, ...}:

{
  # i3 configuration
  services.xserver = {

    enable = true;

    displayManager.lightdm.greeters.mini = {
      enable = true;
      user = "carlos";
      extraConfig = ''
      [greeter]
      show-password-label = false
      show-input-cursor = false
      password-alignment = center

      [greeter-hotkeys]
      mod-key = meta
      shutdown-key = p
      restart-key = r
      hibernate-key = h
      suspend-key = s

      [greeter-theme]
      background-image = ""
      background-color = "#000000"
      window-color = "#585858"
      border-color = "#585858"
      border-width = 1px
      layout-space = 5
      password-color = "#FFFFFF"
      password-background-color = "#000000"
      password-border-color = "#000000"
      password-border-width = 1px
      '';
    };

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
