{ pkgs, ... }:

{
  imports = [
    ./btop
    ./git
    ./gpg
    ./mpv
    ./nvim
    ./swayimg
    ./syncthing
    ./term
    ./vesktop
    ./yazi
    ./zathura
    ./zen
  ];

  home.packages = with pkgs; [
    # System apps/generic
    btop
    bc # calculator
    ncdu # Disk space checker

    # Media toold
    ffmpeg
    imagemagick
    qbittorrent
    yt-dlp
    gpu-screen-recorder

    # Compilation/coding
    gnumake
    libgcc
    qmk
    sops

    # Gaming tools
    nvtopPackages.amd
    ryzenadj
    
    # Sound/music tools
    jellyfin-tui
    picard
    pulsemixer
  ];
}
