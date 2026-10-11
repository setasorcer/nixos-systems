{
  home.file.".config/umbriel/binds.toml".text = ''
    [keybinds]
    
    # Applications and session
    "Mod+D" = { action = "spawn:noctalia msg panel-toggle launcher", repeat = false }
    "Mod+B" = { action = "spawn:noctalia msg panel-toggle control-center", repeat = false }
    "Mod+Backspace" = { action = "spawn:noctalia msg panel-toggle session", repeat = false }
    "Mod+Q" = { action = "window-close", repeat = false }
    "Mod+Escape" = "session-quit"
    "Mod+Shift+Escape" = { action = "shortcuts-inhibit-toggle", allow_when_inhibited = true, repeat = false }
    "Mod+Return" = { action = "spawn:$TERMINAL", repeat = false }
    "Mod+R" = { action = "spawn:$TERMINAL yazi", repeat = false }
    "Mod+W" = { action = "spawn:zen-beta", repeat = false }
    "XF86Tools" = "dpms-off"
    "XF86AudioMedia" = "dpms-off"
    "Shift+F12" = "dpms-off"
    
    # Focus and movement
    "Mod+H" = "column-move-left"
    "Mod+J" = "window-focus-previous"
    "Mod+K" = "window-focus-next"
    "Mod+L" = "column-move-right"
    "Mod+Shift+H" = "window-consume-or-expel-left"
    "Mod+Shift+BracketLeft" = "window-move-or-workspace-down"
    "Mod+Shift+BracketRight" = "window-move-or-workspace-up"
    "Mod+Shift+L" = "window-consume-or-expel-right"
    "Mod+I" = "column-focus-first"
    "Mod+A" = "column-focus-last"
    "Mod+Shift+I" = "column-move-to-first"
    "Mod+Shift+A" = "column-move-to-last"
    
    # Window state and layout
    "Mod+Shift+V" = { action = "window-toggle-floating", repeat = false }
    "Mod+V" = { action = "window-focus-switch-floating", repeat = false }
    "Mod+P" = { action = "window-toggle-pinned", repeat = false }
    "Mod+F" = { action = "window-toggle-fullscreen", repeat = false }
    "Mod+M" = { action = "window-toggle-maximize", repeat = false }
    "Mod+Semicolon" = "window-cycle-primary-extent"
    "Mod+Shift+Semicolon" = "window-cycle-primary-extent-back"
    "Mod+Apostrophe" = "window-cycle-primary-extent-back"
    "Mod+O" = { action = "overview-toggle", repeat = false }
    
    # Workspaces
    "Mod+BracketRight" = "workspace-previous"
    "Mod+BracketLeft" = "workspace-next"
    
    # Scratchpad
    #"Mod+Shift+Space" = { action = "window-move-to-scratchpad", repeat = false }
    "Mod+Z" = "scratchpad-toggle:music"
    #"Mod+Ctrl+Space" = { action = "window-restore-from-scratchpad", repeat = false }
    #"Mod+Tab" = "scratchpad-focus-next"
    
    # Media
    "XF86AudioRaiseVolume" = { action = "spawn:noctalia msg volume-up 5", allow_when_locked = true }
    "XF86AudioLowerVolume" = { action = "spawn:noctalia msg volume-down 5", allow_when_locked = true }
    "XF86AudioMute" = { action = "spawn:noctalia msg volume-mute", allow_when_locked = true }
    "XF86MonBrightnessUp" = { action = "spawn:noctalia msg brightness-up", allow_when_locked = true }
    "XF86MonBrightnessDown" = { action = "spawn:noctalia msg brightness-down", allow_when_locked = true }
    "XF86AudioPlay" = "spawn:noctalia msg media toggle"
    "XF86AudioStop" = "spawn:noctalia msg media stop"
    "XF86AudioPrev" = "spawn:noctalia msg media previous"
    "XF86AudioNext" = "spawn:noctalia msg media next"
    "Mod+Down" = "spawn:noctalia msg media toggle"
    "Mod+Up" = "spawn:noctalia msg media stop"
    "Mod+Left" = "spawn:noctalia msg media previous"
    "Mod+Right" = "spawn:noctalia msg media next"
    
    "Print" = "spawn:noctalia msg screenshot-fullscreen"
    "Shift+Print" = "spawn:noctalia msg screenshot-annotate"
    "Alt+Print" = "spawn:noctalia msg screenshot-region"
  '';
}
