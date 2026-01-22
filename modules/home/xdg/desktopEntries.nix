{ ... }:

{
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
    "com.libretro.RetroArch" = {
      name = "RetroArch";
      exec = "env DRI_PRIME=1 WAYLAND_DISPLAY= retroarch %U";
      icon = "com.libretro.RetroArch";
      type = "Application";
      categories = [ "Game" "Emulator" ];
    };
  };
}
