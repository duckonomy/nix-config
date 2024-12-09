# Generate a .desktop file for swayimg
{...}: let
  browser = "google-chrome.desktop";
  editor = "emacs.desktop";
  media-player = "mpv.desktop";
  image-viewer = "swayimg.desktop";
in {
  xdg = {
    enable = true;

    mimeApps = {
      enable = true;
      associations.added = {
        "audio/mpeg" = [media-player];
        "image/jpeg" = ["org.xfce.ristretto.desktop"];
        "image/jpg" = ["org.xfce.ristretto.desktop"];
        "image/png" = ["org.xfce.ristretto.desktop"];
        "video/mp3" = [media-player];
        "video/mp4" = [media-player];
        "video/quicktime" = [media-player];
        "video/webm" = [media-player];
        "x-scheme-handler/tg" = ["org.telegram.desktop.desktop"];
      };
      defaultApplications = {
        "application/x-extension-htm" = browser;
        "application/x-extension-html" = browser;
        "application/x-extension-shtml" = browser;
        "application/x-extension-xht" = browser;
        "application/x-extension-xhtml" = browser;
        "application/xhtml+xml" = browser;
        "text/html" = browser;
        "x-scheme-handler/about" = browser;
        "x-scheme-handler/chrome" = browser;
        "x-scheme-handler/ftp" = browser;
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;
        "x-scheme-handler/unknown" = browser;

        "application/json" = [editor];
        "application/pdf" = browser;
        "application/toml" = editor;
        "audio/*" = [media-player];
        "audio/mp3" = [media-player];
        "image/*" = ["org.xfce.ristretto.desktop"];
        "image/jpg" = ["org.xfce.ristretto.desktop"];
        "image/png" = ["org.xfce.ristretto.desktop"];
        "text/plain" = editor;
        "video/*" = [media-player];
        "video/mp4" = [media-player];
        "x-scheme-handler/tg" = ["org.telegram.desktop.desktop"];
      };
    };

    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}
