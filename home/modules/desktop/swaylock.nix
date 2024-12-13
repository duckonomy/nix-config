{...}: {
  programs.swaylock = {
    enable = true;
    settings = {
      color = "212121";
      font-size = 24;
      indicator-idle-visible = false;
      indicator-radius = 100;
      line-color = "ffffff";
      show-failed-attempts = true;
    };
  };
}
