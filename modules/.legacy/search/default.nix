{ pkgs, ... }:

{
  imports = [
    ./style.nix
  ];

  # Extra goodies
  home.packages = with pkgs; [
    rofi-power-menu # Power menu
  ];
  # Launcher
  programs.rofi = {
    enable = true;
    # rofi accessories
    plugins = [ pkgs.rofi-emoji ];
  };
}
