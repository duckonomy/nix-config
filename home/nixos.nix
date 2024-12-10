{...}: {
  imports = [
    ./modules/common.nix
    ./modules/desktop/sway.nix
    ./modules/gui/zoom.nix
    ./modules/gui/mpv.nix
    ./modules/gui/browser.nix
    ./modules/gui/packages.nix
  ];


  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}
