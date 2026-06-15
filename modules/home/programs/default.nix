{ pkgs, ... }:

{
  imports = [
    ./btop
    ./git
    ./gpg
    ./jellyfin-tui
    ./mpv
    ./nvim
    ./sops
    ./swayimg
    ./foot
    #./vesktop
    ./yazi
    ./zathura
    ./zen
  ];

  home.packages = with pkgs; [
    # System monitoring
    ncdu # Disk space checker
    nvtopPackages.amd
    ryzenadj

    # Multimedia tools
    ffmpeg
    imagemagick
    yt-dlp
    gpu-screen-recorder

    # Compilation/coding
    gnumake
    libgcc
    sops

    # Sound/music tools
    jellyfin-mpv-shim
    opencloud-desktop
    pulsemixer

    # Misc
    sgdboop
    vesktop
  ];
}
