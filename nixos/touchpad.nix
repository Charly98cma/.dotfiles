{ config, pkgs, ... }:

{
  services.xserver.libinput = {
    enable = true;
    touchpad = {
      naturalScrolling = true;
      clickMethod = "buttonareas";
      disableWhileTyping = true;
      middleEmulation = true;
      tapping = true;

      additionalOptions = ''
        Option "PalmDetection" "on"
        Option "TappingButtonMap" "lmr"
      '';
    };
  };
}
