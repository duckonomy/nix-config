{
  pkgs,
  ...
}: let
  wallpaper = ./../../files/wallpapers/wallpaper.jpg;
  sway_config = ./../../files/configs/sway/config;
in {
  imports = [
    ./cliphist.nix
    ./gtk.nix
    ./kanshi.nix
    ./swappy.nix
    ./swaync.nix
    ./waybar.nix
    ./wofi.nix
    ./xdg.nix
  ];

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.adwaita;
    name = "Adwaita";
    size = 24;
  };

  xdg.portal = {
    enable = true;
    config.sway = {
      default = [
        "gtk"
        "wlr"
        "gnome"
      ];
      # Source: https://gitlab.archlinux.org/archlinux/packaging/packages/sway/-/commit/87acbcfcc8ea6a75e69ba7b0c976108d8e54855b
      "org.freedesktop.impl.portal.Inhibit" = "none";

      # wlr interfaces
      "org.freedesktop.impl.portal.ScreenCast" = "wlr";
      "org.freedesktop.impl.portal.Screenshot" = "wlr";

      # gnome-keyring interfaces
      "org.freedesktop.impl.portal.Secret" = "gnome-keyring";

      # GTK interfaces
      "org.freedesktop.impl.portal.FileChooser" = "gtk";
      "org.freedesktop.impl.portal.AppChooser" = "gtk";
      "org.freedesktop.impl.portal.Print" = "gtk";
      "org.freedesktop.impl.portal.Notification" = "gtk";
      "org.freedesktop.impl.portal.Access" = "gtk";
      "org.freedesktop.impl.portal.Account" = "gtk";
      "org.freedesktop.impl.portal.Email" = "gtk";
      "org.freedesktop.impl.portal.DynamicLauncher" = "gtk";
      "org.freedesktop.impl.portal.Lockdown" = "gtk";
      "org.freedesktop.impl.portal.Settings" = "gtk";
      "org.freedesktop.impl.portal.Wallpaper" = "gtk";

      # Gnome interfaces
      "org.freedesktop.impl.portal.Background" = "gnome";
      "org.freedesktop.impl.portal.Clipboard" = "gnome";
      "org.freedesktop.impl.portal.InputCapture" = "gnome";
      "org.freedesktop.impl.portal.RemoteDesktop" = "gnome";
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    xdg.configFile = {
      "sway/config" = {
        source = config.lib.file.mkOutOfStoreSymlink "${sway_config}";
      };
    };

    # config = {
    #   workspaceLayout = "default";
    #   bars = [];
    #   terminal = "termite";
    #   modifier = "Mod4";
    #   startup = [
    #     { command = "wl-paste -t text --watch clipman store"; }
    #     { command = "clipman restore"; }
    #     { command = "waybar"; }
    #     { command = "ibus-daemon -d -x --cache=refresh"; }
    #     { command = "swaybg -i /home/duckonomy/Pictures/Wallpapers/tactile_noise.png -m tile"; }
    #   ];
    #   window = {
    #     titlebar = false;
    #     border = 10;
    #   };
    #   input = {
    #     "type:keyboard" = {
    #       xkb_layout = "us";
    #       xkb_options = "custom:rctrl_hanja,custom:rwin_hangul,custom:prsc_hangul,custom:ralt_lalt,custom:nocapsescape,custom:lalt_lctl";
    #       repeat_delay = "250";
    #       repeat_rate = "20";
    #     };
    #     "type:pointer" = {
    #       accel_profile = "flat";
    #     };
    #     "type:touchpad" = {
    #       tap = "enabled";
    #       natural_scroll = "enabled";
    #     };
    #   };
    #   keybindings = let
    #     modifier = config.wayland.windowManager.sway.config.modifier;
    #   in {
    #     "${modifier}+Bracketleft" = "workspace prev";
    #     "${modifier}+Bracketright" = "workspace next";
    #     "${modifier}+Shift+Bracketleft" = "move container to workspace prev";
    #     "${modifier}+Shift+Bracketright" = "move container to workspace next";
    #     "${modifier}+1" = "workspace number 1";
    #     "${modifier}+2" = "workspace number 2";
    #     "${modifier}+3" = "workspace number 3";
    #     "${modifier}+4" = "workspace number 4";
    #     "${modifier}+5" = "workspace number 5";
    #     "${modifier}+6" = "workspace number 6";
    #     "${modifier}+7" = "workspace number 7";
    #     "${modifier}+8" = "workspace number 8";
    #     "${modifier}+9" = "workspace number 9";
    #     "${modifier}+Shift+1" = "move container to workspace number 1";
    #     "${modifier}+Shift+2" = "move container to workspace number 2";
    #     "${modifier}+Shift+3" = "move container to workspace number 3";
    #     "${modifier}+Shift+4" = "move container to workspace number 4";
    #     "${modifier}+Shift+5" = "move container to workspace number 5";
    #     "${modifier}+Shift+6" = "move container to workspace number 6";
    #     "${modifier}+Shift+7" = "move container to workspace number 7";
    #     "${modifier}+Shift+8" = "move container to workspace number 8";
    #     "${modifier}+Shift+9" = "move container to workspace number 9";
    #     "${modifier}+Shift+r" = "reload";
    #     "${modifier}+Shift+q" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

    #     "${modifier}+m" = "scratchpad show";
    #     "${modifier}+Shift+m" = "move scratchpad";
    #     "${modifier}+r" = "mode resize";
    #     "${modifier}+Apostrophe" = "floating toggle";

    #     "${modifier}+h" = "focus left";
    #     "${modifier}+j" = "focus down";
    #     "${modifier}+k" = "focus up";
    #     "${modifier}+l" = "focus right";
    #     "${modifier}+Shift+h" = "move left";
    #     "${modifier}+Shift+j" = "move down";
    #     "${modifier}+Shift+k" = "move up";
    #     "${modifier}+Shift+l" = "move right";
    #     "${modifier}+Return" = "exec ${config.wayland.windowManager.sway.config.terminal}";
    #     "${modifier}+Shift+Return" = "exec ${config.wayland.windowManager.sway.config.terminal} -e tmux";
    #     "${modifier}+c" = "kill";
    #     "${modifier}+f" = "fullscreen toggle";
    #     "${modifier}+a" = "layout toggle tabbed split";
    #     "${modifier}+e" = "emacsclient -c";
    #     "${modifier}+s" = "exec ${pkgs.rofi}/bin/rofi -show run";

    #     "XF86AudioRaiseVolume" = "exec ${pkgs.pulseaudioFull}/bin/pactl set-sink-volume $(${pkgs.pulseaudioFull}/bin/pacmd list-sinks |awk '/* index:/{print $3}') +5%";
    #     "XF86AudioLowerVolume" = "exec ${pkgs.pulseaudioFull}/bin/pactl set-sink-volume $(${pkgs.pulseaudioFull}/bin/pacmd list-sinks |awk '/* index:/{print $3}') -5%";
    #     "XF86AudioMute" = "exec ${pkgs.pulseaudioFull}/bin/pactl set-sink-mute $(${pkgs.pulseaudioFull}/bin/pacmd list-sinks |awk '/* index:/{print $3}') toggle";
    #     "XF86WebCam" = "exec ${pkgs.swaylock}/bin/swaylock -i /home/duckonomy/Picture/catalina.jpg --scaling fill";
    #     "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl s 5%+";
    #     "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl s 5%-";
    #   };
    # };
    extraSessionCommands = ''
    export GTK_IM_MODULE=ibus
    export QT_IM_MODULE=ibus
    export XMODIFIERS=@im=ibus

    export _JAVA_AWT_WM_NONREPARENTING=1
    export MOZ_ENABLE_WAYLAND=1
    export QT_QPA_PLATFORMTHEME=qt5ct
    export QT_QPA_PLATFORM=wayland
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    export QT_AUTO_SCREEN_SCALE_FACTOR=1
    export SDL_VIDEODRIVER=wayland
    export GDK_BACKEND=wayland
    export GDK_SCALE=1
    export XDG_CURRENT_DESKTOP=sway
    export XDG_SESSION_TYPE=wayland
    export CLUTTER_BACKEND=wayland
    export CLUTTER_PAINT=disable-dynamic-max-render-time
    export MUTTER_DEBUG_ENABLE_ATOMIC_KMS=0

    export WLR_NO_HARDWARE_CURSORS=1
    export ECORE_EVAS_ENGINE=wayland_egl
    export ELM_ENGINE=wayland_egl
    export ELECTRON_OZONE_PLATFORM_HINT=auto

    export SSH_AUTH_SOCK=/run/user/1000/keyring/ssh

    export PATH="$HOME/.local/share/pnpm:$HOME/.local/bin:$HOME/bin:$PATH:$HOME/.cargo/bin"
    export PNPM_HOME="/home/iannn/.local/share/pnpm"
    '';
  };
}
