{ config, pkgs, lib, ... }:

{
  # Fish shell
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    shellAbbrs = {
      swwws = "swww img --transition-type grow --transition-fps 165 --transition-step 30";
      hydrus = "hydrus-client -d ${config.home.homeDirectory}/pix/hydrus";
      fetch = "fastfetch";
      h = "hyprctl dispatch dpms on";
    };
  };

  # default directories
  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = "${config.home.homeDirectory}";
    documents = "${config.home.homeDirectory}/dox";
    download = "${config.home.homeDirectory}";
    music = "${config.home.homeDirectory}/music";
    pictures = "${config.home.homeDirectory}/pix";
    publicShare = "${config.home.homeDirectory}/dox/send";
    templates = null;
    videos = "${config.home.homeDirectory}/vid";
  };
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "floorp";
    TERMINAL = "foot";
  };

  # Adwaita icon theme
  gtk.enable = true;
  stylix.icons = {
    enable = true;
    package = lib.mkForce pkgs.adwaita-icon-theme;
    light = "adwaita";
    dark = "adwaita-dark";
  };
}
