{ pkgs, ... }: {
  home.packages = with pkgs; [
    nil # lsp
    nodejs
    python3
    gcc
  ];
}
