{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./cachix.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.systemd-boot.configurationLimit = 3;
    loader.efi.canTouchEfiVariables = true;
    supportedFilesystems = [ "ntfs" ];
    cleanTmpDir = true;
    # extraModulePackages = [ config.boot.kernelPackages.wireguard ];
  };

      # NIXOS_OZONE_WL = "1";


  networking = {
    hostName = "nixos"; # Define your hostname.
    wireless.iwd.enable = true;
    networkmanager.enable = true;

    wireless.enable = true;
    wireless.userControlled.enable = true;
    # networkmanager.wifi.backend = "iwd";
    iproute2.enable = true;
    # extraHosts = ''
    #     127.0.0.1 cep.dev
    # '';

 	  # When I worked @ TACC
    # extraHosts = ''
    #     127.0.0.1 designsafe.dev
    #     127.0.0.1 cep.dev
    #     127.0.0.1 hazmapper.local
    # '';

    # wireguard.interfaces = {
    #   wg0 = {
    #     privateKey = "q6ntZA2GfRSPpWxd3zm37y+XNlTfv3UMlaetJRyL5yw=";
    #     ips = [ "10.72.71.136/32" "fc00:bbbb:bbbb:bb01::9:4787/128" ];
    #     table = "51820";
    #     postSetup = ''
    #       wg set wg0 fwmark 51820
    #       ip -6 rule add not fwmark 51820 table 51820
    #       ip -6 rule add table main suppress_prefixlength 0
    #       ip -4 rule add not fwmark 51820 table 51820
    #       ip -4 rule add table main suppress_prefixlength 0
    #       '';
    #     postShutdown = ''
    #       ip -4 rule delete table 51820
    #       ip -4 rule delete table main suppress_prefixlength 0
    #       ip -6 rule delete table 51820
    #       ip -6 rule delete table main suppress_prefixlength 0
    #     '';
    #     peers = [
    #       {
    #         publicKey = "RW+wwTv4BqRNbHPZFcIwl74f9kuRQlFLxnaocpMyKgw=";
    #         allowedIPs = [ "0.0.0.0/0" "::0/0" ];
    #         endpoint = "174.127.113.8:51820";
    #         persistentKeepalive = 25;
    #       }
    #     ];
    #   };
    # };
  };

  # Set your time zone.
  # time.timeZone = "America/Chicago";
  time.timeZone = "Asia/Seoul";

  virtualisation.docker.enable = true;

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  # nixpkgs.overlays = [
  #   (import (builtins.fetchTarball {
  #     url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
  #   }))
  # ];

  # nixpkgs.overlays = [
  #   (import (builtins.fetchTarball {
  #     url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
  #   }))
  # ];

  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [hangul];
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  hardware.enableAllFirmware = true;

  # services.xserver.enable = true;
  # services.resilio.enable = true;
  environment.extraInit = ''
      #Turn off gui for ssh auth
      unset -v SSH_ASKPASS
    '';

  services.printing.enable = true;
  # services.printing.drivers = with pkgs; [ hplip hplipWithPlugin gutenprint splix cups-googlecloudprint ];

  #  security.pki.certificates = [  ''
  #      ''
  #      designsafe.dev
  #      =========
  #      -----BEGIN CERTIFICATE-----
  #      MIIDPjCCAiYCCQDB5Acq+TCXRzANBgkqhkiG9w0BAQsFADBhMQswCQYDVQQGEwJV
  #      UzELMAkGA1UECAwCVFgxDzANBgNVBAcMBkF1c3RpbjENMAsGA1UECgwEVEFDQzEM
  #      MAoGA1UECwwDV01BMRcwFQYDVQQDDA5EZXNpZ25TYWZlLmRldjAeFw0yMTA0MDEx
  #      OTE0MzhaFw0yMjA0MDExOTE0MzlaMGExCzAJBgNVBAYTAlVTMQswCQYDVQQIDAJU
  #      WDEPMA0GA1UEBwwGQXVzdGluMQ0wCwYDVQQKDARUQUNDMQwwCgYDVQQLDANXTUEx
  #      FzAVBgNVBAMMDkRlc2lnblNhZmUuZGV2MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
  #      MIIBCgKCAQEAsdoemOyzpdziKCiETeFtk/XhjLbbIHty3H4Hnns6Ev6GY1tFbmK4
  #      BFRibo5M0wKX/aQky6R2ZbfJS2NJ6ruiqUeWOxeiDk73JHLsAYZjC9SYuVt0pbhE
  #      r1sAflWDDWkPvmlnO3/IUSqMI9TXSNoMXy+jKciswg7qXc2aRw0IHiEGxgu2Rx17
  #      V0A3xCk/2oheSu5U59wthWMc/pRvvjx9FsGtT/J1QEdkZTHpB64APUP9deRWw7YP
  #      hpEuzn9DWnl+29nrulxJeQI4Ev5lrZVc6yWxzCU0+UuYiLr+mUp7AbnOq5hpvFc3
  #      eBR/NCGgPSeR5lwPOtNiANzVoVM70ML/7QIDAQABMA0GCSqGSIb3DQEBCwUAA4IB
  #      AQCfrjp/RmKGc12+1xdNR8Uy73TgDphJ6LaHENZ9r1eDtBbPzMaN1dLaK0pfHJ01
  #      25nypZ4nHLwRSzfyVWasYSg+jiu9xYCWcXtZ0T0bJtBUHnjsD93bUXkIwgZs0IDc
  #      W6WsRLf/nCCpKADNt+3yfSGX2Av9P+sWlwPKNbUru3vYXLdGxQDd7yuk2EATY8Qc
  #      yokYRORoS4jL3KB5qR62PkUTm0dkEucz4zB1oo3yribP7r7BkumYVWyd5dMzlYgy
  #      7f6RL/EWGXDMPJO36ID4kEgTyehqqyJtuCjf1ngTlSF1qIm/OfzMjFgIWiB0gnoX
  #      L2Pt7chJewGvOhQ1hPbASUhq
  #      -----END CERTIFICATE-----
  #      ''
  #      ''
  # security.pki.certificates = [  ''
  #     cep.dev
  #     -----BEGIN CERTIFICATE-----
  #     MIIDNDCCAhwCCQCfcBxIzyQM/jANBgkqhkiG9w0BAQsFADBcMQswCQYDVQQGEwJV
  #     UzEOMAwGA1UECAwFVGV4YXMxDzANBgNVBAcMBkF1c3RpbjENMAsGA1UECgwEVEFD
  #     QzEMMAoGA1UECwwDV01BMQ8wDQYDVQQDDAZDRVAgQ0EwHhcNMjEwNDAxMTkwMjU0
  #     WhcNMjIwNDAxMTkwMjU0WjBcMQswCQYDVQQGEwJVUzEOMAwGA1UECAwFVGV4YXMx
  #     DzANBgNVBAcMBkF1c3RpbjENMAsGA1UECgwEVEFDQzEMMAoGA1UECwwDV01BMQ8w
  #     DQYDVQQDDAZDRVAgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDM
  #     hp/T6b2a45b3RgxV9IZVGx421kCa6ld+An6GZ8I33zw/xfylcN9br6pPyM7i1zkH
  #     r17Xf5nri0WbwTe38D4vVLMRmy/Irf32kELnSSM12xvhtu4Pul+NvkeWAox93nw8
  #     4n9kAwzOg/qVyJDd9wbe9UYI2Fppxva6DsQve3S2BZVy+DHJQIvc0r/RE2cV9cHi
  #     GBaMxIV34PEJ6DTOIcoQU1hX/Hyvx43UBhkKcafttJbCFduWtIEc+d2CGMyMzD2l
  #     /Tur3KpV8lG6Pjm8vM/OYa0USTweGPyLn2OwZEu9WZBNkJUyfPVa7hARjDUg8Bv/
  #     IgutaOuyWpoS2rMBrtopAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAJj0i9EKnAYc
  #     T6/OuBGqFkwlwi0X0iAUST2P9SGC9PImCOEL2B3q6lQFOMKGbkC4MnW+2zKchMpa
  #     FbuI8Sa9Bashp6IuoWE2NEaKPI9Tyjl+GxO7JMveUeEmMCQDFzMlTruQydrOEmJd
  #     fvgASJcP2VjJbZqSDR4onoNrve7FeABBUQ3weZiKqVg9O4Pc77NsbSW7101I+41G
  #     DHFBqLBeU49sFODJd5vWCY+j1Ec5o7Dm4AglPPg8Yr9vtfauuCL2Er4yq1r+T4ls
  #     PEm3qqjnJ3YKBvuxzBZOsg2hdFf6RqTtwkW4f5e9c6z0J4kqfMnZLukKaq6aYvOD
  #     q/EcpD5weFc=
  #     -----END CERTIFICATE-----
  #     ''
  # ];


  # security.pki.certificates = [  ''
  #     cep.dev
  #     -----BEGIN CERTIFICATE-----
  #     MIIDNDCCAhwCCQCfcBxIzyQM/jANBgkqhkiG9w0BAQsFADBcMQswCQYDVQQGEwJV
  #     UzEOMAwGA1UECAwFVGV4YXMxDzANBgNVBAcMBkF1c3RpbjENMAsGA1UECgwEVEFD
  #     QzEMMAoGA1UECwwDV01BMQ8wDQYDVQQDDAZDRVAgQ0EwHhcNMjEwNDAxMTkwMjU0
  #     WhcNMjIwNDAxMTkwMjU0WjBcMQswCQYDVQQGEwJVUzEOMAwGA1UECAwFVGV4YXMx
  #     DzANBgNVBAcMBkF1c3RpbjENMAsGA1UECgwEVEFDQzEMMAoGA1UECwwDV01BMQ8w
  #     DQYDVQQDDAZDRVAgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDM
  #     hp/T6b2a45b3RgxV9IZVGx421kCa6ld+An6GZ8I33zw/xfylcN9br6pPyM7i1zkH
  #     r17Xf5nri0WbwTe38D4vVLMRmy/Irf32kELnSSM12xvhtu4Pul+NvkeWAox93nw8
  #     4n9kAwzOg/qVyJDd9wbe9UYI2Fppxva6DsQve3S2BZVy+DHJQIvc0r/RE2cV9cHi
  #     GBaMxIV34PEJ6DTOIcoQU1hX/Hyvx43UBhkKcafttJbCFduWtIEc+d2CGMyMzD2l
  #     /Tur3KpV8lG6Pjm8vM/OYa0USTweGPyLn2OwZEu9WZBNkJUyfPVa7hARjDUg8Bv/
  #     IgutaOuyWpoS2rMBrtopAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAJj0i9EKnAYc
  #     T6/OuBGqFkwlwi0X0iAUST2P9SGC9PImCOEL2B3q6lQFOMKGbkC4MnW+2zKchMpa
  #     FbuI8Sa9Bashp6IuoWE2NEaKPI9Tyjl+GxO7JMveUeEmMCQDFzMlTruQydrOEmJd
  #     fvgASJcP2VjJbZqSDR4onoNrve7FeABBUQ3weZiKqVg9O4Pc77NsbSW7101I+41G
  #     DHFBqLBeU49sFODJd5vWCY+j1Ec5o7Dm4AglPPg8Yr9vtfauuCL2Er4yq1r+T4ls
  #     PEm3qqjnJ3YKBvuxzBZOsg2hdFf6RqTtwkW4f5e9c6z0J4kqfMnZLukKaq6aYvOD
  #     q/EcpD5weFc=
  #     -----END CERTIFICATE-----

  #     designsafe.dev
  #     =========
  #     -----BEGIN CERTIFICATE-----
  #     MIIDPjCCAiYCCQDB5Acq+TCXRzANBgkqhkiG9w0BAQsFADBhMQswCQYDVQQGEwJV
  #     UzELMAkGA1UECAwCVFgxDzANBgNVBAcMBkF1c3RpbjENMAsGA1UECgwEVEFDQzEM
  #     MAoGA1UECwwDV01BMRcwFQYDVQQDDA5EZXNpZ25TYWZlLmRldjAeFw0yMTA0MDEx
  #     OTE0MzhaFw0yMjA0MDExOTE0MzlaMGExCzAJBgNVBAYTAlVTMQswCQYDVQQIDAJU
  #     WDEPMA0GA1UEBwwGQXVzdGluMQ0wCwYDVQQKDARUQUNDMQwwCgYDVQQLDANXTUEx
  #     FzAVBgNVBAMMDkRlc2lnblNhZmUuZGV2MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
  #     MIIBCgKCAQEAsdoemOyzpdziKCiETeFtk/XhjLbbIHty3H4Hnns6Ev6GY1tFbmK4
  #     BFRibo5M0wKX/aQky6R2ZbfJS2NJ6ruiqUeWOxeiDk73JHLsAYZjC9SYuVt0pbhE
  #     r1sAflWDDWkPvmlnO3/IUSqMI9TXSNoMXy+jKciswg7qXc2aRw0IHiEGxgu2Rx17
  #     V0A3xCk/2oheSu5U59wthWMc/pRvvjx9FsGtT/J1QEdkZTHpB64APUP9deRWw7YP
  #     hpEuzn9DWnl+29nrulxJeQI4Ev5lrZVc6yWxzCU0+UuYiLr+mUp7AbnOq5hpvFc3
  #     eBR/NCGgPSeR5lwPOtNiANzVoVM70ML/7QIDAQABMA0GCSqGSIb3DQEBCwUAA4IB
  #     AQCfrjp/RmKGc12+1xdNR8Uy73TgDphJ6LaHENZ9r1eDtBbPzMaN1dLaK0pfHJ01
  #     25nypZ4nHLwRSzfyVWasYSg+jiu9xYCWcXtZ0T0bJtBUHnjsD93bUXkIwgZs0IDc
  #     W6WsRLf/nCCpKADNt+3yfSGX2Av9P+sWlwPKNbUru3vYXLdGxQDd7yuk2EATY8Qc
  #     yokYRORoS4jL3KB5qR62PkUTm0dkEucz4zB1oo3yribP7r7BkumYVWyd5dMzlYgy
  #     7f6RL/EWGXDMPJO36ID4kEgTyehqqyJtuCjf1ngTlSF1qIm/OfzMjFgIWiB0gnoX
  #     L2Pt7chJewGvOhQ1hPbASUhq
  #     -----END CERTIFICATE-----
  #     ''
  #                             ];

  sound.enable = true;
  security.rtkit.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    extraModules = [ pkgs.pulseaudio-modules-bt ];
    extraConfig = ''
      load-module module-switch-on-connect
    '';
    # configFile = pkgs.writeText "default.pa" ''
    #  load-module module-bluetooth-policy
    #  load-module module-bluetooth-discover
    #'';
    package = pkgs.pulseaudioFull;
    tcp = {
      enable = true;
      anonymousClients.allowedIpRanges = ["127.0.0.1"];
    };
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  }
  services.blueman.enable = true;

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };


  # services.blueman.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };


  # let
  #   compiledLayout = pkgs.runCommand "keyboard-layout" {} ''
  #     ${pkgs.xorg.xkbcomp}/bin/xkbcomp -I/home/duckonomy/.config/xkb ${/home/duckonomy/layout.xkb} $out
  #   '';
  # in
  # services.xserver.displayManager.sessionCommands = "${pkgs.xorg.xkbcomp}/bin/xkbcomp -I/home/duckonomy/.config/xkb ${compiledLayout} $DISPLAY";


  # COMMENTED: sway probs handles this
  # services.xserver.extraLayouts = {
  #   kr-better = {
  #     description = "Better Korean";
  #     languages = ["eng"];
  #     symbolsFile = builtins.toFile "kr-better" ''
  #     default  alphanumeric_keys
  #     xkb_symbols "kr-better106" {
  #         include "us"
  #         name[Group1]= "Korean (Modified)";
  #         include "kr-better(hw_keys)"

  #         // korean:rwin_hangul
  #         replace key <RWIN> {
  #             type[Group1] = "ONE_LEVEL",
  #             symbols[Group1]= [ Hangul ]
  #         };

  #         // korean:rctrl_hanja // Default
  #         replace key <RCTL> {
  #             type[Group1] = "ONE_LEVEL",
  #             symbols[Group1]= [ Hangul_Hanja ]
  #         };

  #         // korean:prsc_hangul
  #         replace key <PRSC> { [ Hangul ] };
  #         replace key <TLDE> { [ Escape ] };
  #         replace key <ESC> { [ grave, asciitilde ] };
  #         replace key <MENU> { [ Hangul ] };

  #         // korean:prsc_hangul_lv
  #         replace key <PRSC> {
  #             type[Group1] = "ONE_LEVEL",
  #             symbols[Group1] = [ Hangul ]
  #         };

  #         // korean:ralt_lalt
  #         replace key <RALT> { [ Alt_L, Meta_L ] };
  #     };

  #     alphanumeric_keys
  #     xkb_symbols "kr-better104" {
  #         include "us"
  #         name[Group1]= "Korean (101/104 key compatible) (modified)";
  #         include "kr-better(ralt_hangul)"
  #         include "kr-better(rctrl_hanja)"

  #         replace key <PRSC> { [ Hangul ] };
  #         replace key <TLDE> { [ Escape ] };
  #         replace key <ESC> { [ grave, asciitilde ] };
  #         replace key <MENU> { [ Hangul ] };
  #     };

  #     partial function_keys
  #     xkb_symbols "hw_keys" {
  #         key <HNGL> { [ Hangul       ] };
  #         key <HJCV> { [ Hangul_Hanja ] };
  #     };

  #     partial function_keys
  #     xkb_symbols "tlde_escape" {
  #         replace key <ESC> {
  #             [ grave, asciitilde ]
  #         };
  #     };

  #     partial function_keys
  #     xkb_symbols "escape_tlde" {
  #         replace key <TLDE> {
  #             [ Escape ]
  #         };
  #     };

  #     partial function_keys
  #     xkb_symbols "ralt_hangul" {
  #         replace key <RALT> {
  #             type[Group1] = "ONE_LEVEL",
  #             symbols[Group1]= [ Hangul ]
  #         };
  #     };

  #     partial function_keys
  #     xkb_symbols "rctrl_hangul" {
  #         replace key <RCTL> {
  #             type[Group1] = "ONE_LEVEL",
  #             symbols[Group1]= [ Hangul ]
  #         };
  #     };

  #     partial function_keys
  #     xkb_symbols "ralt_hanja" {
  #         replace key <RALT> {
  #             type[Group1] = "ONE_LEVEL",
  #             symbols[Group1]= [ Hangul_Hanja ]
  #         };
  #     };

  #     partial function_keys
  #     xkb_symbols "rctrl_hanja" {
  #         replace key <RCTL> {
  #             type[Group1] = "ONE_LEVEL",
  #             symbols[Group1]= [ Hangul_Hanja ]
  #         };
  #     };
  #     '';
  #   };
  # };

  programs.light.enable = true;

  # services.xserver.displayManager.sessionCommands = "${pkgs.xorg.xkbcomp}/bin/xkbcomp -I/home/duckonomy/.config/xkb /home/duckonomy/layout.xkb $DISPLAY";


  # JUST UNCOMMENT FROM HERE TO  (READBOTTOM)
  services.xserver = {
    enable = true;
    desktopManager = {
      gnome.enable = true;
    };

    displayManager = {
      gdm.enable = true;
    };
  };

  services.xserver.libinput.enable = true;

  # COMMENTED: sway probs handles this
  # services.xserver.libinput.touchpad.naturalScrolling = true;
  # services.xserver.libinput.touchpad.accelProfile = "flat";
  # services.xserver.libinput.touchpad.accelSpeed = "0";

  # COMMENTED: sway probs handles this
  # services.xserver.libinput.mouse.accelProfile = "flat";
  # services.xserver.libinput.mouse.accelSpeed = "0";
  # services.xserver.config = ''
  #   Section "InputClass"
  #     Identifier "mouse accel"
  #     Driver "libinput"
  #     MatchIsPointer "on"
  #     Option "AccelProfile" "flat"
  #     Option "AccelSpeed" "0"
  #   EndSection
  # '';





  # COMMENTED: sway probs handles this
  # services.xserver.layout = "kr-better";
  # services.xserver.xkbOptions = "caps:escape, ctrl:swap_lalt_lctl";
  # services.xserver.autoRepeatInterval = 40;
  # services.xserver.autoRepeatDelay = 200;





  # services.xserver.xkbOptions = "custom:rctrl_hanja, custom:rwin_hangul, custom:prsc_hangul, custom:ralt_lalt, custom:nocapsescape, custom:lalt_lctl";
  # services.xserver.exportConfiguration = true;

  networking.wireguard.enable = true;
  # services.mullvad-vpn.enable = true;

  # NOTE: Needed For Gnome
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.displayManager.gdm.wayland = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # NOTE: Needed for window manager
  # services.xserver.displayManager.startx.enable = true;
  services.xserver.videoDrivers = [ "intel" ];

  # services.flatpak.enable = true;
  # xdg.portal.enable = true;
  # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # NOTE: Not Needed For Gnome
  # gnome3.chrome-gnome-shell.enable = true;

  users.mutableUsers = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.duckonomy = {
    isNormalUser = true;
    home = "/home/duckonomy";
    description = "Ian Park";
    extraGroups = [ "wheel" "networkmanager" "docker" "audio" "video" ];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;
  # NOTE: Needed for window manager
  # services.xrdp.defaultWindowManager = "bspwm";


  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # TODO: Needed for Gnome
  # environment.gnome.excludePackages = [ pkgs.gnome.cheese pkgs.gnome-photos pkgs.gnome.gnome-music pkgs.gnome.gnome-terminal pkgs.gnome.gedit pkgs.epiphany pkgs.evince pkgs.gnome.gnome-characters pkgs.gnome.totem pkgs.gnome.tali pkgs.gnome.iagno pkgs.gnome.hitori pkgs.gnome.atomix pkgs.gnome-tour ];

  # # NOTE: Needed For Gnome
  # services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  # # TODO: Culprit of IBus not working on google-chrome and firefox
  # services.dbus.packages = with pkgs; [ dconf ];

  environment.systemPackages = with pkgs; [
    # xorg.xorgserver
    # gnomeExtensions.appindicator
    # xorg.xinit
    # xorg.xf86videointel
    # jdk11
    # spring-boot
    # wireguard-tools
    # mullvad-vpn
    # scrot
    grim # screenshot functionality
    slurp # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    mako # notification system developed by swaywm maintainer
    vim
    wget
    tmux
    swaylock

    # xorg.xorgserver
    # xorg.xf86inputevdev


  ];
  environment.sessionVariables.NIXOS_OZONE_WL = "1"
  # TODO: REAL Culprit of IBus not working on google-chrome and firefox (maybe because it reads in profile
  programs.zsh.enable = true;
  # So that it doesn't interfere with local prompt
  programs.zsh.promptInit = "";

  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';

  nix.autoOptimiseStore = true;

  # NOTE: Needed for Gnome
  programs.dconf.enable = true;

  networking.firewall = {
    allowedUDPPorts = [ 51820 ]; # Clients and peers can use the same port, see listenport
  };

  networking.firewall.extraCommands = ''
      iptables -I INPUT 1 -i vboxnet+ -p tcp -m tcp --dport 2049 -j ACCEPT
  '';

  # virtualisation.virtualbox.host.enable = true;

  users.extraGroups.vboxusers.members = [ "duckonomy" ];

  # services.throttled.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  # system.stateVersion = "21.03"; # Did you read the comment?

  system = {
    stateVersion = "23.05";
    activationScripts.linkBash = {
      text = ''
        ln -sf ${pkgs.bash}/bin/bash /bin/bash
      '';
    };

  };

  nix = {
    gc = {
	    automatic = true;
	    dates = "weekly";
	    options = "--delete-older-than 14d";
    };

    #optimise.automatic = true;
    settings.experimental-features = [ "nix-command" "flakes" ];

  };


  security = {
    polkit = {
      enable = true;
      extraConfig = ''
      polkit.addRule(function(action, subject) {
         if (
            subject.isInGroup("users")
              && (
                action.id == "org.freedesktop.login1.reboot" ||
                action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
                action.id == "org.freedesktop.login1.power-off" ||
                action.id == "org.freedesktop.login1.power-off-multiple-sessions"
            )
          )
          {
            return polkit.Result.YES;
          }
        });
      '';
    };

    pam = {
      # Enable realtime
      loginLimits = [
        { domain = "@users"; item = "rtprio"; type = "-"; value = 1; }
      ];
      services = {
        sway = {};
        swaylock = {};
        greetd.enableGnomeKeyring = true
      };
    }
  };

  services.gnome.gnome-keyring.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        # Parameterize
        user = "duckonomy";
        # user = "greeter";
      };
    };
  };


  services = {
    gvfs.enable = true; # Nautilus
    devmon.enable = true;
    udisks2.enable = true;
    upower.enable = true;
    power-profiles-daemon.enable = true;
    accounts-daemon.enable = true;
  };

  services.dbus.enable = true;
  # services.dbus.packages = [ pkgs.gnome.seahorse ];

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk]; # gtk portal needed to make gtk apps happy
  };


  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };



# security = {
#   polkit = {
#     enable = true;
#   };

#   gnome.gnome-keyring-enable = true;
#   users.users.greeter = {};

#   # # might have to move this to nix-configurations


};
