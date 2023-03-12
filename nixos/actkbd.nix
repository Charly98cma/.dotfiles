{ config, pkgs, ... }:

{
  services.actkbd = {
    enable = true;
    bindings = [
      # Backlight
      { keys = [ 224 ]; events = [ "key" "rep" ]; command = "${pkgs.light}/bin/light -U 10"; }
      { keys = [ 225 ]; events = [ "key" "rep" ]; command = "${pkgs.light}/bin/light -A 10"; }

      # Key to turn off/on screen
      #{ keys = [ 152 ];
      #  command = (toString (pkgs.writeTextFile {
      #    name = "dark-script";
      #    text = ''
      #      if [[ `${pkgs.light}/bin/light | head -c -4` -eq 0 ]]
      #      then
      #        ${pkgs.light}/bin/light -I
      #      else
      #        ${pkgs.light}/bin/light -O
      #        ${pkgs.light}/bin/light -S 0
      #      fi'';
      #    executable = true;})); 
      #}

      # Playerctl (music controls) NOT WORKING
      # { keys = [ 59 125 ]; events = [ "rel" ]; command = "${pkgs.playerctl}/bin/playerctl play-pause"; }
      # { keys = [ 60 125 ]; events = [ "rel" ]; command = "${pkgs.playerctl}/bin/playerctl previous"; }
      # { keys = [ 61 125 ]; events = [ "rel" ]; command = "${pkgs.playerctl}/bin/playerctl next"; }
    ];
  };
}
