{ pkgs, ... }:

{
  imports = [
    ./btop
    ./git
    ./gpg
    ./mpv
    ./nvim
    ./swayimg
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

    # Compilation/coding
    gnumake
    libgcc
    sops

    # Sound/music tools
    jellyfin-tui
    jellyfin-mpv-shim
    opencloud-desktop
    pulsemixer

    # Misc
    hyprpicker
    accountsservice
    sgdboop
  ];
}
