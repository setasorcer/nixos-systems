{
  # Disable some desktop entries to tidy up the launcher
  xdg.desktopEntries = {
    "org.fcitx.fcitx5-migrator" = {
      name = "Fcitx5 Migration Wizard";
      exec = "fcitx5-migrator";
      icon = "fcitx";
      settings.NoDisplay = "true";
    };
    "org.pwmt.zathura-cb" = {
      name = "Zathura";
      exec = "zathura %U";
      icon = "org.pwmt.zathura";
      settings.NoDisplay = "true";
      terminal = false;
      type = "Application";
      mimeType = [ "application/x-cbr" "application/x-rar" "application/x-cbz" "application/zip" "application/x-cb7" "application/x-7z-compressed" "application/x-cbt" "application/x-tar"];
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
      exec = "env WAYLAND_DISPLAY= retroarch %U";
      icon = "com.libretro.RetroArch";
      type = "Application";
      categories = [ "Game" "Emulator" ];
    };
  };
}
