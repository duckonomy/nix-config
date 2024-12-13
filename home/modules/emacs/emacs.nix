{ pkgs, ... }: {
  # services.emacs = {
  #   enable = true;
  # };

  # home.packages = with pkgs; [
  #   aspell
  #   aspellDicts.en
  #   aspellDicts.en-computers
  # ];

  # programs.emacs = {
  #   p
  #   # enable = true;
  #   # recommendedGcSettings = true;
  #   # usePackage = {
  #   #   abbrev = {
  #   #     enable = true;
  #   #     diminish = [ "abbrev-mode" ];
  #   #     command = [ "abbrev-mode" ];
  #   #   };
  #   # };
  # };

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-unstable-pgtk;
    extraPackages = (epkgs:
      (with epkgs; [
        vterm
        pdf-tools
        nix-mode
        treesit-grammars.with-all-grammars
      ]));
  };
}
