{...}: {
  imports = [
    ./modules/common.nix
    # ./desktop/sway.nix

    # COMMENTED
    # ./modules/gui/zoom.nix

    ./modules/gui/mpv.nix

    # COMMENTED
    # ./modules/gui/browser.nix
    # ./modules/gui/browser-pass.nix

    # ./modules/gui/packages.nix
  ];


  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}
