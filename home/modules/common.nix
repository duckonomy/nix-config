{outputs, ...}: {
  imports = [
    ./fonts/home-path.nix
    ./fonts/packages.nix
    ./cli/alacritty.nix
    ./cli/development.nix
    ./cli/utils.nix
    ./cli/shell.nix
    ./cli/security.nix
    ./cli/packages.nix
    # ./cli/scripts.nix
    ./langs/go.nix
    ./langs/packages.nix
    # ./emacs/mail.nix
    # TODO: Adjust for emacs-plus
    ./emacs/emacs.nix
    ./emacs/packages.nix
  ];

  # Nixpkgs configuration
  nixpkgs = {
    overlays = [
      (import (builtins.fetchTarball {
        url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
      }))
    ];

    config = {
      allowUnfree = true;
    };
  };
}
