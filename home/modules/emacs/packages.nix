{ pkgs, ... }: {
  home.packages = with pkgs; [
    ispell
    sqlite
    emacs-lsp-booster
  ];
}
