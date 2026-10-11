{
  home.file.".config/umbriel/rules.toml".text = ''
    [[window_rule]]
    blur = true
    blur_optimized = true
    
    [[window_rule]]
    match.is_alone = true
    default_maximize = true
    
    [[window_rule]]
    match.app_id = "^dev.noctalia.Noctalia$"
    default_floating = true
    default_floating_size_px = { width = 1020, height = 900 }
    
    [[window_rule]]
    match.app_id = "^dev.noctalia.UmbrielSharePicker$"
    default_floating = true
    default_floating_size_px = { width = 800, height = 600 }
    
    [[window_rule]]
    match.title = "^(Picture-in-Picture|Picture in picture)$"
    default_floating = true
    default_maximize = false
    default_position = { x = 20, y = 20, anchor = "bottom_right" }
    default_floating_size = { width = 0.4, height = 0.352 }
    
    [[window_rule]]
    match.title = "^notificationtoasts_.+_desktop"
    default_position = { x = 0, y = 0, anchor = "bottom_right" }
    default_focused = false
    default_pinned = true
    
    [[window_rule]]
    match.app_id = "^vesktop$"
    default_scrolling_extent = 0.333
    
    [[window_rule]]
    match.app_id = "^zen-beta$"
    default_scrolling_extent = 0.667
    
    [[window_rule]]
    match.app_id = "^footclient$"
    default_scrolling_extent = 0.333
    
    # Scratchpads
    [[scratchpad]]
    name = "music"
    spawn_when_empty = "$TERMINAL -a music jellyfin-tui"
    
    [[window_rule]]
    match.app_id = "^music$"
    default_scratchpad = "music"
    default_floating_size = { width = 0.5, height = 0.6 }

    [[layer_rule]]
    match.namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd|desktop-widget-[^\"]*)$"
    blur = true
    blur_ignore_alpha = 0.5
    blur_popups = true
    blur_optimized = false
  '';
}
