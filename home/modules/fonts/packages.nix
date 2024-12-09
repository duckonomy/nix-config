{ pkgs, ... }: {
  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
    nerd-fonts.mplus
    nerd-fonts.fira-code
    nerd-fonts.d2coding
    corefonts
    inter
    sarasa-gothic
    iosevka
    powerline-fonts
    material-icons
    unifont
  ];
}
