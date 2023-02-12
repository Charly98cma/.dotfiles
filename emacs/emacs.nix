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

    doom-modeline  # ; FIXME ¿Config?
    doom-themes

    helm

    magit          # ; Integrate git <C-x g>
    zerodark-theme # ; Nicolas' theme

  ]) ++ (with epkgs.melpaPackages; [ 

    multiple-cursors
    # autopair # flex-autopair OR phi-autopair ???
    rainbow-delimiters

    all-the-icons

  ]) ++ (with epkgs.elpaPackages; [ 

    undo-tree      # ; <C-x u> to show the undo tree

    auctex         # ; LaTeX mode
    beacon         # ; highlight my cursor when scrolling
    nameless       # ; hide current package name everywhere in elisp code

  ]) ++ [
  ])
