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
    # System monitoring
    bc # calculator
    ncdu # Disk space checker
    nvtopPackages.amd
    ryzenadj

    # Multimedia toold
    ffmpeg
    imagemagick
    yt-dlp
    gpu-screen-recorder
    qbittorrent

    # Compilation/coding
    gnumake
    libgcc
    qmk
    sops

    # Sound/music tools
    jellyfin-tui
    picard
    pulsemixer

    # Misc
    hyprpicker
  ];
}
