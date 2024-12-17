{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;
    settings = {
      window.padding = {
        x = 20;
        y = 20;
      };
      window.decorations = "Full";
      font = {
        normal.family = "Iosevka Term Nerd Font";
        size = 12;
      };
      # Colors (Everforest)
      colors = {
        # Default colors
        primary = {
          background = "#2f383e";
          foreground = "#d3c6aa";
        };
        # Cursor colors
        cursor = {
          text = "#d8cbb2";
          cursor = "#d8cbb2";
        };
        # Normal colors
        normal = {
          black =   "#606c73";
          red =     "#e67e80";
          green =   "#a7c080";
          yellow =  "#dbbc7f";
          blue =    "#7fbbb3";
          magenta = "#d699b6";
          cyan =    "#83c092";
          white =   "#d3c6aa";
        };
        # Bright colors
        bright = {
          black =   "#606c73";
          red =     "#e67e80";
          green =   "#a7c080";
          yellow =  "#dbbc7f";
          blue =    "#7fbbb3";
          magenta = "#d699b6";
          cyan =    "#83c092";
          white =   "#d3c6aa";
        };
        # Selection colors
        selection = {
          text = "#d8cbb2";
          background = "#573e4c";
        };
      };
    };
  };
}
