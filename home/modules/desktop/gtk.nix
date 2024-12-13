{
  userConfig,
  pkgs,
  ...
}: {
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };

    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Classic";
    };
    font = {
      package = pkgs.inter;
      name = "Inter";
      size = 10;
    };
    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
      bookmarks = [
        "file:///home/${userConfig.name}/Documents"
        "file:///home/${userConfig.name}/Downloads"
        "file:///home/${userConfig.name}/Pictures"
        "file:///home/${userConfig.name}/Videos"
        "file:///home/${userConfig.name}/Downloads/temp"
        "file:///home/${userConfig.name}/Documents/repositories"
      ];
    };
  };
}
