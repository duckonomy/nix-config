{ pkgs, ... }: {
  home.packages = with pkgs; [
    wget
    curl
    unzip
    unrar
    killall
    pass
    yt-dlp
    jq
    dash
    nix-zsh-completions
    gnumake
    bc
    fd
    ngrok
  ];
}
