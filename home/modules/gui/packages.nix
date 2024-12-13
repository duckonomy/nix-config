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
    swayimg
    gcolor3
  ];
}
