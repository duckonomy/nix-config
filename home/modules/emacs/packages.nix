{ pkgs, ... }: {
  home.packages = with pkgs; [
    ispell
    sqlite
  ];
}
