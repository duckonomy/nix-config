{ config, pkgs, inputs, userConfig, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  system = {
    stateVersion = "24.11";
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
	    options = "--delete-older-than 7d";
    };

    # Flakes
    package = pkgs.nixVersions.git;
    registry.nixpkgs.flake = inputs.nixpkgs;

    settings = {
      auto-optimise-store = true;

      trusted-users = [ "root" "duckonomy" ];

      warn-dirty = false;

      substituters = [
        "https://cache.nixos.org"
        "https://cache.garnix.io"
        "https://nix-community.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      experimental-features = [ "nix-command" "flakes" ];

      # Avoid unwanted garbage collection when using nix-direnv
      keep-outputs = true;
      keep-derivations = true;
    };
  };

  nixpkgs.config.allowUnfree = true;

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 3;
      };
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = [ "ntfs" ];
    tmp.cleanOnBoot = true;
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 30;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enable = true;
      type = "kime";
      kime.iconColor = "White";
    # inputMethod = {
    #   enabled = "ibus";
    #   ibus.engines = with pkgs.ibus-engines; [hangul];
    # };
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  time.timeZone = "Asia/Seoul";

  networking = {
    hostName = "nixos";
    wireless = {
      iwd.enable = true;
      userControlled.enable = true;
    };

    firewall.enable = false;

    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
    };

    iproute2.enable = true;
    wireguard.enable = true;
  };

  services = {
    xserver = {
      videoDrivers = [ "intel" ];
    };

    libinput.enable = true;

    blueman.enable = true;

    printing = {
      enable = true;
      drivers = [ pkgs.epson-escpr ];
    };

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      wireplumber= {
        enable = true;
        wireplumber.extraConfig."10-bluez" = {
          "monitor.bluez.properties" = {
            "bluez5.enable-sbc-xq" = true;
            "bluez5.enable-msbc" = true;
            "bluez5.enable-hw-volume" = true;
            "bluez5.roles" = [
              "hsp_hs"
              "hsp_ag"
              "hfp_hf"
              "hfp_ag"
            ];
          };
        };
      };
    };

    openssh = {
      enable = true;
      allowSFTP = true;
    };

    sshd.enable = true;

    avahi = {
      enable = true;
      nssmdns4 = true;
    };

    gvfs.enable = true;
    devmon.enable = true;
    udisks2.enable = true;
    upower.enable = true;
    power-profiles-daemon.enable = true;
    accounts-daemon.enable = true;

    gnome.gnome-keyring.enable = true;

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
          user = "duckonomy";
        };
      };
    };

    dbus.enable = true;
  };

  hardware = {
    enableAllFirmware = true;

    # pulseaudio = {
    #   enable = true;
    #   support32Bit = true;
    #   extraModules = [ pkgs.pulseaudio-modules-bt ];
    #   extraConfig = ''
    #     load-module module-switch-on-connect
    #   '';
    #   package = pkgs.pulseaudioFull;
    #   tcp = {
    #     enable = true;
    #     anonymousClients.allowedIpRanges = ["127.0.0.1"];
    #   };
    # };

    bluetooth = {
      enable = true;
      powerOnBoot = true;
      package = pkgs.pulseaudioFull;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-ocl
        intel-vaapi-driver
        libva-vdpau-driver
        libvdpau-va-gl
      ];
    };
  };

  programs = {
    zsh = {
      enable = true;
      promptInit = "";
    };

    light.enable = true;

    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
  };

  users = {
    mutableUsers = true;
    defaultUserShell = pkgs.zsh;
    users.duckonomy = {
      isNormalUser = true;
      home = "/home/duckonomy";
      description = "${userConfig.fullName}";
      extraGroups = [ "wheel" "networkmanager" "docker" "audio" "video" "lp" "scanner"];
      shell = pkgs.zsh;
    };
    extraGroups.vboxusers.members = [ "duckonomy" ];
  };

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    extraInit = ''
      #Turn off gui for ssh auth
      unset -v SSH_ASKPASS
    '';

    systemPackages = with pkgs; [
      vim
      wget
      tmux
    ];
  };

  virtualisation = {
    docker= {
      enable = true;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };
  };

  security = {
    rtkit.enable = true;

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
            };
        });
      '';
    };

    pam = {
      # Enable realtime for snappier sway
      loginLimits = [
        { domain = "@users"; item = "rtprio"; type = "-"; value = 1; }
      ];
      services = {
        sway = {};
        swaylock = {};
        greetd.enableGnomeKeyring = true
      };
    };
  };

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
}
