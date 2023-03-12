{ config, pkgs, ... }

# TODO Emacs configuration
{
  services.emacs = {
    # Emacs daemon on login
    enable = true;
  };
}
