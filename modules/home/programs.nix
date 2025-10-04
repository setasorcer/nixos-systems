{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    # System apps/generic
    btop
    bc # calculator
    ncdu # Disk space checker

    # Suites/complex programs
    ffmpeg
    imagemagick
    qbittorrent
    vesktop
    yt-dlp

    # Compilation/coding
    gnumake
    libgcc
    qmk

    # Gaming tools
    nvtopPackages.amd
    ryzenadj
    
    # Sound/music tools
    pamixer
    pulsemixer
  ];
  programs = {
    zathura.enable = true;
    foot = {
      enable = true;
      settings = {
        main = {
          pad = "24x24";
        };
        colors = {
          background = lib.mkForce "${config.stylix.base16Scheme.base01}";
        };
      };
    };
    btop = {
      enable = true;
      settings = {
        vim_keys = true;
      };
    };
    git = {
      enable = true;
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
  };
}
