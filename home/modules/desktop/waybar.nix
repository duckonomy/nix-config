{...}: let
  waybar_config = ./../../files/configs/waybar;
in {

  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "sway-session.target";
    };
  };

  xdg.configFile = {
    "waybar" = {
      recursive = true;
      source = "${waybar_config}";
    };
  };
}
