# TODO: https://github.com/nix-community/nur-combined
# TODO: consider MacOS once I get a mac
# TODO: browserpass, chromium extensions, pam, gnome-keyring, libsecret, polkit services.pass-secret-service.enable password-store ssh-agent (ditch gnome-keyring with pass and gpg agent)
# TODO: autologin with pam
# TODO: https://www.reddit.com/r/NixOS/comments/1eo2etv/screen_sharing_in_sway/
# TODO: Emacs macos overlay with emacs-plus patches
# https://github.com/nix-community/emacs-overlay
# https://github.com/AlexNabokikh/nix-config/blob/master/home/modules/zoom.nix
# https://github.com/AlexNabokikh/nix-config/blob/master/home/modules/hyprland.nix
# https://nix-community.github.io/home-manager/options.xhtml
# https://nixos.wiki/wiki/Jetbrains_Tools
# https://github.com/Gerschtli/nix-config/blob/master/home/misc/sdks.nix
# https://github.com/Gerschtli/nix-config/blob/master/home/base/general.nix
# TODO: muchsync vs isync
# NOTE: Why zsh? cuz it's default on macos and I can port easily
# https://github.com/apognu/tuigreet
{
  description = "My Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hardware.url = "github:nixos/nixos-hardware";

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = {
    self,
      darwin,
      home-manager,
      nix-homebrew,
      nixpkgs,
      ...
  } @ inputs: let
    inherit (self) outputs;

    users = {
      duckonomy = {
        # avatar = ./files/avatar/face;
        email = "contact@duckonomy.com";
        fullName = "Ian Park";
        # gitKey = "C5810093";
        name = "duckonomy";
      };
    };

    mkNixosConfiguration = hostname: username:
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs hostname;
          userConfig = users.${username};
        };
        modules = [./hosts/${hostname}/configuration.nix];
      };

    mkDarwinConfiguration = hostname: username:
      darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit inputs outputs hostname;
          userConfig = users.${username};
        };
        modules = [
          ./hosts/${hostname}/configuration.nix
          home-manager.darwinModules.home-manager
          nix-homebrew.darwinModules.nix-homebrew
        ];
      };

    mkHomeConfiguration = system: username: hostname:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {inherit system;};
        extraSpecialArgs = {
          inherit inputs outputs;
          userConfig = users.${username};
        };
        modules = [
          ./home/${hostname}.nix
        ];
      };

    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {

    nixosConfigurations = {
      nixos = mkNixosConfiguration "nixos" "duckonomy";
    };

    darwinConfigurations = {
      "mac" = mkDarwinConfiguration "mac" "duckonomy";
    };

    # https://github.com/nix-community/home-manager/issues/1341
    # https://github.com/nix-community/home-manager/issues/432
    # https://github.com/hraban/mac-app-util
    homeConfigurations = {
      "duckonomy@mac" = mkHomeConfiguration "aarch64-darwin" "duckonomy" "mac";
      "duckonomy@nixos" = mkHomeConfiguration "x86_64-linux" "duckonomy" "nixos";
    };

    overlays = import ./overlays {inherit inputs;};

    # homeConfigurations = {
    #   duckonomyProfile = home-manager.lib.homeManagerConfiguration {
    #     inherit pkgs;
    #     modules = [ ./home.nix ];
    #   };
    # };
  };
}
