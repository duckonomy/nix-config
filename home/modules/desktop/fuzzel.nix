{...}: {
  programs.fuzzel = {
    settings = {
      main = {
        terminal = "${pkgs.alacritty}/bin/alacritty";
        layer = "overlay";
        prompt = "$ ";
        horizontal-pad=50;
        vertical-pad=50;
        inner-pad=20;
        image-size-ratio=0.5;
      };
      colors = {
        background="090909ff";
        text="ddddddff";
        match="777777ff";
        selection="404040ff";
        selection-text="eeeeeeff";
        selection-match="777777ff";
        border="bbbbbbff";
      };
      key-bindings = {
        prev-page="Mod1+v";
        next-page="Control+v";
      };
    };
  };
