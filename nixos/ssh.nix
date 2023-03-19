{ config, pkgs, programs, ... }:

{
  programs.ssh = {
    forwardX11 = true;
    startAgent = true;
    # SSH hosts configuration
    extraConfig = "
      Host triqui1
        Hostname triqui1.fi.upm.es
        User z170243

      Host github.com
        User Charly98cma
        Hostname github.com
        PreferredAuthentications publickey
        IdentityFile ~/.ssh/github_key

      # FICODES GitLab credentials
      Host gitlab.com/ficodes
        PreferredAuthentications publickey
        IdentityFile ~/.ssh/ficodes_gitlab

      # SSH to ACMUPM PC (admins)
      Host acm
        Hostname acm.asoc.fi.upm.es
        user admins
        Port 2222
    ";
  };
}
