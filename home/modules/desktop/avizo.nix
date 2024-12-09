{...}: {
  services.avizo = {
    enable = true;
    settings = {
      default = {
        time = 1.0;
        padding = 24;
        image-opacity = 0.1;
        width = 248;
        height = 232;
        padding = 24;
        y-offset = 0.75;
        x-offset = 0.5;
        border-radius = 16;
        border-width = 1;
        block-height = 10;
        block-spacing = -1;
        block-count = 20;
        fade-in = 0.2;
        fade-out = 0.5;
        background = "rgba(0, 0, 0, 0.8)";
        border-color = "rgba(20, 20, 20, 0.8)";
        bar-fg-color = "rgba(160, 160, 160, 0.8)";
        bar-bg-color = "rgba(40, 40, 40, 0.8)";
      }
    }
  };
}
