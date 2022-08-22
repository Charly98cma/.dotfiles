{ config, pkgs, ... }

{
  services.emacs = {
    # Emacs daemon on login
    enable = true;
  };
}
