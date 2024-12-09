{ pkgs, ... }: {
  home.packages = with pkgs; [
    gnome.adwaita-icon-theme
    libadwaita
    pavucontrol
    wl-clipboard
    rofi-pass
    rofi
    # ibus-engines.hangul
    brightnessctl
    libnotify
  ];
}
