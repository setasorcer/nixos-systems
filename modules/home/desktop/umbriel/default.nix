{
  imports = [
    ./binds.nix
    ./colors.nix
    ./rules.nix
  ];

  home.file.".config/umbriel/config.toml".text = ''
    [include]
    files = [ "binds.toml", "colors.toml", "rules.toml" ]

    [include.optional]
    files = [ "optional.toml" ]

    [appearance]
    border_width = 3
    corner_radius = 16

    [appearance.blur]
    radius = 3

    [input.keyboard]
    numlock_toggle = true
    repeat_rate = 50
    repeat_delay = 300

    [input.touchpad]
    natural_scroll = true
    click_method = "clickfinger"
    
    [input.cursor]
    hide_timeout_ms = 3000

    [layout]
    gap = 16
    extent_presets = [0.333, 0.5, 0.667]
    
    [layout.scrolling]
    default_extent_fraction = 0.5
    
    [layout.struts]
    top = 8
    bottom = 8
    left = 16
    right = 16

    [hot_corners.top_left]
    enabled = true
    delay_ms = 200
    action = "overview-open"
  '';
}
