{
  userConfig,
  pkgs,
  ...
}: {
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita";
      package = pkgs.gnome3.gnome_themes_standard;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome3.adwaita-icon-theme;
    };
    cursorTheme = {
      name = "Adwaita";
    };
    font = {
      package = pkgs.inter;
      size = 12;
    };
    gtk3 = {
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
