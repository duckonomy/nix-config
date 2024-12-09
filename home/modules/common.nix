{outputs, ...}: {
  imports = [
    ./fonts/home-path.nix
    ./fonts/packages.nix
    ./cli/alacritty.nix
    ./cli/atuin.nix
    ./cli/bat.nix
    ./cli/btop.nix
    ./cli/direnv.nix
    ./cli/eza.nix
    ./cli/fd.nix
    ./cli/fzf.nix
    ./cli/git.nix
    ./cli/gpg.nix
    ./cli/password-store.nix
    ./cli/readline.nix
    ./cli/ripgrep.nix
    # ./cli/scripts.nix
    ./cli/starship.nix
    ./cli/zoxide.nix
    ./cli/zsh.nix
    ./cli/packages.nix
    ./langs/go.nix
    ./langs/packages.nix
    # ./emacs/mail.nix
    # # TODO: Adjust for emacs-plus
    # ./emacs/emacs.nix
    # ./emacs/packages.nix
  ];

  # Nixpkgs configuration
  nixpkgs = {
    overlays = [
      outputs.overlays.stable-packages
    ];

    config = {
      allowUnfree = true;
    };
  };
}
