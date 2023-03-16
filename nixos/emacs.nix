{ config, pkgs, ... }:

{
  # EMACS config and service
  services.emacs = {
    # Emacs daemon on login
    enable = true;
    defaultEditor = true;
  };
}
