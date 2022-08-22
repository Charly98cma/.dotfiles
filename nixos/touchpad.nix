{ config, pkgs, ... }:

{

  # Enable touchpad control FIXME: DOES NOT WORK
  services.xserver.libinput.enable = true;
  services.xserver.libinput.touchpad = {
    clickMethod = "buttonareas";
    disableWhileTyping = true;
    middleEmulation = true;
    tapping = true;

    additionalOptions = ''
      Option "PalmDetection" "on"
      Option "TappingButtonMap" "lmr"
    '';
  };

}
