{...}:
{
  services.swayidle = {
    enable = true;
    systemdTarget = "sway-session.target";
    timeouts = [
      {
        timeout = 300;
        command = "swaylock";
      }
      {
        timeout = 600;
        command = "swaymsg \"output * dpms off";
      }
    ];
    events = [
      {
        event = "before-sleep";
        command = "swaylock";
      }
      {
        event = "after-resume";
        command = "swaymsg \"output * dpms on";
      }
      {
        event = "lock";
        command = "swaylock";
      }
    ];
  };
}
