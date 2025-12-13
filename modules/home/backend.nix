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
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  # hide certain desktop entries in launcher
  xdg.desktopEntries = {
    "org.fcitx.fcitx5-migrator" = {
      name = "Fcitx5 Migration Wizard";
      exec = "fcitx5-migrator";
      icon = "fcitx";
      settings.NoDisplay = "true";
    };
    "org.gnome.Nautilus" = {
      name = "Files";
      exec = "nautilus --new-window";
      icon = "org.gnome.Nautilus";
      settings.NoDisplay = "true";
    };
    "kbd-layout-viewer5" = {
      name = "Keyboard layout viewer";
      exec = "kbd-layout-viewer5";
      icon = "input-keyboard";
      settings.NoDisplay = "true";
    };
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
