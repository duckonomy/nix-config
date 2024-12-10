{ pkgs, ... }: {
  home.packages = with pkgs; [
    gnome.adwaita-icon-theme
    libadwaita
    pavucontrol
    wl-clipboard
    networkmanager_dmenu
    fuzzel
    brightnessctl
    libnotify
    grim
    slurp
  ];
}
