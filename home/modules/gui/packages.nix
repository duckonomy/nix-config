{ pkgs, ... }: {
  home.packages = with pkgs; [
    postman
    element-desktop
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
