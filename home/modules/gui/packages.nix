{ pkgs, ... }: {
  home.packages = with pkgs; [
    postman
    discord
    slack
    audacity
    obs-studio
    gimp
    inkscape
    zathura
    etcher
    google-chrome
    swayimg
    gcolor3
  ];
}
