{ pkgs, ... }: {
  home.packages = with pkgs; [
    wget
    curl
    unzip
    unrar
    p7zip
    killall
    yt-dlp
    jq
    dash
    nix-zsh-completions
    gnumake
    bc
    fd
    ngrok
    ansible
    docker-compose
    imagemagick
    ffmpeg
    pinentry-curses
  ];
}
