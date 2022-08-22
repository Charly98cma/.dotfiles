/*
https://nixos.org/manual/nixos/stable/index.html#module-services-emacs

To build the project, type the following from the current directory:

$ nix-build emacs.nix

To run the newly compiled executable:

$ ./result/bin/emacs
*/
{ pkgs ? import <nixpkgs> {} } :

let 
  myEmacs = pkgs.emacs;
  emacsWithPackages = (pkgs.emacsPackagesFor myEmacs).emacsWithPackages;
in
  emacsWithPackages (epkgs: (with epkgs.melpaStablePackages; [ 

    magit          # ; Integrate git <C-x g>
    zerodark-theme # ; Nicolas' theme

  ]) ++ (with epkgs.melpaPackages; [ 

    undo-tree      # ; <C-x u> to show the undo tree
    zoom-frm       # ; increase/decrease font size for all buffers %lt;C-x C-+>

  ]) ++ (with epkgs.elpaPackages; [ 

    auctex         # ; LaTeX mode
    beacon         # ; highlight my cursor when scrolling
    nameless       # ; hide current package name everywhere in elisp code

  ]) ++ [
  ])
