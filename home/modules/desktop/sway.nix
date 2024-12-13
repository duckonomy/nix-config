{
  pkgs,
  ...
}: let
  # wallpaper = ./../../files/wallpapers/wallpaper.jpg;
  sway_config = ./../../files/configs/sway/config;
in {
  imports = [
    ./cliphist.nix
    ./fuzzel.nix
    ./gnome-keyring.nix
    ./gtk.nix
    ./kanshi.nix
    ./mako.nix
    # ./swayidle.nix
    ./swaylock.nix
    ./swayosd.nix
    ./udiskie.nix
    ./waybar.nix
    ./xdg.nix
  ];

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
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
    config = {
      workspaceLayout = "default";
      bars = [];
      fonts = {
        names = [ "Inter" ];
        style = "Bold";
        size = 10.0;
      };
      terminal = "alacritty";
      modifier = "Mod4";
      startup = [
        { command = "wl-paste -t text --watch clipman store"; }
        { command = "playerctld"; }
        { command = "nm-applet"; }
        { command = "ibus-daemon -rxRd --cache=refresh"; }
        { command = "swaybg -m fill -i ~/Pictures/wallpapers/desert.jpg"; }
      ];
      window = {
        border = 5;
      };
      input = {
        # "type:keyboard" = {
        "1:1:AT_Translated_Set_2_keyboard" = {
          xkb_layout = "us";
          xkb_options = "custom:nocapsescape,custom:lalt_lctl,custom:menu_hangul,custom:ralt_hangul";
          repeat_delay = "200";
          repeat_rate = "20";
        };
        "7247:132:LIZHI_Flash_IC_USB_Keyboard" = {
          xkb_layout = "us";
          xkb_options = "custom:nocapsescape,custom:lalt_lctl,custom:hangul_lalt";
          repeat_delay = "200";
          repeat_rate = "20";
        };
        "type:pointer" = {
          accel_profile = "flat";
        };
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
          scroll_factor = "0.2";
          dwt = "enabled";
          middle_emulation = "enabled";
          accel_profile = "flat";
          pointer_accel = "0.5";
        };
      };
      keybindings = let
        modifier = "Mod4";
      in {
        "${modifier}+Bracketleft" = "workspace prev";
        "${modifier}+Bracketright" = "workspace next";
        "${modifier}+Shift+Bracketleft" = "move container to workspace prev";
        "${modifier}+Shift+Bracketright" = "move container to workspace next";
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+r" = "reload";
        "${modifier}+Shift+q" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

        "${modifier}+m" = "scratchpad show";
        "${modifier}+Shift+m" = "move scratchpad";
        "${modifier}+r" = "mode resize";
        "${modifier}+Shift+g" = "floating toggle";
        "${modifier}+g" = "focus mode_toggle";
        "${modifier}+n" = "focus child";
        "${modifier}+p" = "focus parent";

        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";
        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";
        "${modifier}+Return" = "exec alacritty";
        "${modifier}+c" = "kill";
        "${modifier}+Shift+c" = "exec swaymsg -t get_tree | jq '.. | select(.type?) | select(.focused==true) | .pid' | xargs kill -9";
        "${modifier}+f" = "fullscreen";
        "${modifier}+a" = "layout tabbed";
        "${modifier}+d" = "layout toggle split";
        "${modifier}+b" = "splith";
        "${modifier}+v" = "splitv";
        "${modifier}+e" = "exec XMODIFIERS='' GTK_IM_MODULE='' emacs";
        "${modifier}+s" = "exec fuzzel --list-executables-in-path";
        "${modifier}+i" = "exec grim -g \"$(slurp -p)\" -t ppm - | convert - -format '%[pixel:p{0,0}]' txt:- | tail -n 1 | cut -d ' ' -f 4 | wl-copy";

        "XF86AudioRaiseVolume" = "exec swayosd-client --output-volume raise";
        "XF86AudioLowerVolume" = "exec swayosd-client --output-volume lower";
        "XF86AudioMute" = "exec swayosd-client --output-volume mute-toggle";
        "XF86MonBrightnessUp" = "exec swayosd-client --brightness raise";
        "XF86MonBrightnessDown" = "exec swayosd-client --brightness lower";
      };

    };
    extraConfig = ''
        client.focused            #444444    #191919    #999999    #98c379    #444444
        client.unfocused          #111111    #000000    #aaaaaa    #111111    #111111
        client.focused_inactive   #111111    #000000    #aaaaaa    #111111    #111111
        client.urgent             #e06c75    #000000    #aaaaaa    #e06c75    #e06c75

        bindgesture swipe:right workspace prev
        bindgesture swipe:left workspace next
        smart_borders off
        titlebar_padding 5

        workspace_auto_back_and_forth yes
        # Enable floating for pinentry
        for_window [title="pinentry-gnome3"] floating enable, move position center
        for_window [class="Pavucontrol"] floating enable
        for_window [class="KakaoTalk"] floating enable

        # Float zoom windows
        #for_window [app_id="zoom"] floating enable

        # No titles on things I tend to keep on their own workspaces (browsers, slack)
        for_window [class="google-chrome"] border pixel
        for_window [app_id="firefox"] border pixel
        for_window [class="Slack"] border pixel
        for_window [app_id="firefox-trunk"] border pixel
        for_window [app_id="gnome-terminal-server"] border pixel

        # Inhibit idle for fullscreen browser stuff (mostly to prevent locking when watching youtube videos)
        for_window [app_id="firefox-trunk"] inhibit_idle fullscreen
        for_window [app_id="google-chrome"] inhibit_idle fullscreen
        for_window [app_id="firefox"] inhibit_idle fullscreen
      '';
    # extraSessionCommands = ''
    # export GTK_IM_MODULE=ibus
    # export QT_IM_MODULE=ibus
    # export XMODIFIERS=@im=ibus

    # export _JAVA_AWT_WM_NONREPARENTING=1
    # export MOZ_ENABLE_WAYLAND=1
    # export QT_QPA_PLATFORMTHEME=qt5ct
    # export QT_QPA_PLATFORM=wayland
    # export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    # export QT_AUTO_SCREEN_SCALE_FACTOR=1
    # export SDL_VIDEODRIVER=wayland
    # export GDK_BACKEND=wayland
    # export GDK_SCALE=1
    # export XDG_CURRENT_DESKTOP=sway
    # export XDG_SESSION_TYPE=wayland
    # export CLUTTER_BACKEND=wayland
    # export CLUTTER_PAINT=disable-dynamic-max-render-time
    # export MUTTER_DEBUG_ENABLE_ATOMIC_KMS=0

    # export WLR_NO_HARDWARE_CURSORS=1
    # export ECORE_EVAS_ENGINE=wayland_egl
    # export ELM_ENGINE=wayland_egl
    # export ELECTRON_OZONE_PLATFORM_HINT=auto

    # export SSH_AUTH_SOCK=/run/user/1000/keyring/ssh

    # export PATH="$HOME/.local/share/pnpm:$HOME/.local/bin:$HOME/bin:$PATH:$HOME/.cargo/bin"
    # export PNPM_HOME="/home/iannn/.local/share/pnpm"
    # '';
  };
}
