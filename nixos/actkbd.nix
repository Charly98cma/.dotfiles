{ config, pkgs, ... }:

{
  services.actkbd = {
    enable = true;

    bindings = [
    
      # Backlight
      { keys = [ 224 ]; events = [ "rel" ]; command = "${pkgs.light}/bin/light -U 20"; }
      { keys = [ 225 ]; events = [ "rel" ]; command = "${pkgs.light}/bin/light -A 20"; }
      { keys = [ 152 ];
        command = (toString (pkgs.writeTextFile {
          name = "dark-script";
          text = ''
            if [[ `${pkgs.light}/bin/light | head -c -4` -eq 0 ]]
            then
              ${pkgs.light}/bin/light -I
            else
              ${pkgs.light}/bin/light -O
              ${pkgs.light}/bin/light -S 0
            fi'';
          executable = true;
      }));}

      # Audio
      #{ keys = [ 113 ]; events = [ "key" ]; command = "${alsa-utils}/bin/amixer set Master 5%+"; }
      #{ keys = [ 114 ]; events = [ "key" ]; command = "${alsa-utils}/bin/amixer set Master 5%-"; }
      #{ keys = [ 115 ]; events = [ "key" ]; command = "${alsa-utils}/bin/amixer set Master toggle"; }
    ];
  };
}
