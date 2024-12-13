{ pkgs, ... }: {
  home.packages = with pkgs; [
    libadwaita
    pavucontrol
    wl-clipboard
    networkmanager_dmenu
    brightnessctl
    libnotify
    grim
    slurp
    playerctl
    swaybg
    nwg-look
    networkmanagerapplet
  ];
}
