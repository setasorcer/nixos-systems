{ config, pkgs, ... }:

{

  home.packages = [ pkgs.swayimg ];
  home.file.".config/swayimg/config".text = ''
    # Swayimg configuration file.
    # vim: filetype=dosini
    
    # Any of these options can be overridden using the --config argument
    # on the command line, for instance:
    # $ swayimg --config="general.mode=gallery"
    
    [general]
    # Mode at startup (viewer/gallery)
    mode = viewer
    # Window position (parent or absolute coordinates, e.g. 100,200)
    position = parent
    # Window size (fullscreen/parent/image, or absolute size, e.g. 800,600)
    size = image
    # Use window decoration (yes/no)
    decoration = yes
    # Action performed by SIGUSR1 signal (same format as for key bindings)
    sigusr1 = reload
    # Action performed by SIGUSR2 signal (same format as for key bindings)
    sigusr2 = next_file
    # Integrate with Wayland compositor (Sway/Hyprland only)
    compositor = no
    # Application ID and window class name
    app_id = swayimg
    
    [viewer]
    # Window background color (RGBA)
    window = #${config.stylix.base16Scheme.base01}E6
    # Background for transparent images (grid/RGBA)
    transparency = grid
    # Default image scale (optimal/fit/width/height/fill/real)
    scale = optimal
    # Keep absolute zoom across images (yes/no)
    keep_zoom = no
    # Initial image position
    position = center
    # Fix position of the image on the window surface (yes/no)
    fixed = yes
    # Anti-aliasing mode (none/box/bilinear/bicubic/mks13)
    antialiasing = mks13
    # Run slideshow at startup (yes/no)
    slideshow = no
    # Slideshow image display time (seconds)
    slideshow_time = 3
    # Number of previously viewed images to store in cache
    history = 1
    # Number of preloaded images (read ahead)
    preload = 1
    
    [gallery]
    # Size of the thumbnail (pixels)
    size = 200
    # Max number of thumbnails in memory cache, 0 for unlimited
    cache = 100
    # Enable/disable storing thumbnails in persistent storage (yes/no)
    pstore = yes
    # Fill the entire tile with thumbnail (yes/no)
    fill = no
    # Anti-aliasing mode for thumbnails (none/box/bilinear/bicubic/mks13)
    antialiasing = mks13
    # Background color of the window (RGBA)
    window = #${config.stylix.base16Scheme.base01}E6
    # Background color of the tile (RGBA)
    background = #${config.stylix.base16Scheme.base01}E6
    # Background color of the selected tile (RGBA)
    select = #${config.stylix.base16Scheme.base01}E6
    # Border color of the selected tile (RGBA)
    border = #${config.stylix.base16Scheme.base01}E6
    # Shadow color of the selected tile (RGBA)
    shadow = #${config.stylix.base16Scheme.base01}FF
    
    [list]
    # Default order (none/alpha/reverse/random)
    order = alpha
    # Looping list of images (yes/no)
    loop = yes
    # Read directories recursively (yes/no)
    recursive = no
    # Open all files in the directory of the specified file (yes/no)
    all = yes
    
    [font]
    # Font name
    name = Inconsolata Nerd Font Propo
    # Font size (pt)
    size = 14
    # Font color (RGBA)
    color = #${config.stylix.base16Scheme.base07}FF
    # Shadow color (RGBA)
    shadow = #${config.stylix.base16Scheme.base01}CC
    # Background color (RGBA)
    background = #${config.stylix.base16Scheme.base01}E6
    #background = #00000000
    
    [info]
    # Show on startup (yes/no)
    show = yes
    # Timeout to hide info (seconds, 0 to always show)
    info_timeout = 5
    # Timeout to hide status message (seconds)
    status_timeout = 3
    
    # Display scheme for viewer mode (position = content)
    [info.viewer]
    top_left = +name,+format,+filesize,+imagesize
    top_right = index
    bottom_left = scale,frame
    bottom_right = status
    
    # Display scheme for gallery mode (position = content)
    [info.gallery]
    top_left = none
    top_right = none
    bottom_left = none
    bottom_right = name,status
    
    [keys.viewer]
    F1 = help
    g = first_file
    Shift+g = last_file
    p = prev_file
    n = next_file
    Space = next_file
    Shift+r = rand_file
    Shift+d = prev_dir
    d = next_dir
    Shift+o = prev_frame
    o = next_frame
    c = skip_file
    Shift+s = slideshow
    Ctrl+Space = animation
    f = fullscreen
    Return = mode
    h = step_left 10
    l = step_right 10
    k = step_up 10
    j = step_down 10
    Equal = zoom +10
    Plus = zoom +10
    Minus = zoom -10
    w = zoom width
    Shift+w = zoom height
    z = zoom fit
    Shift+z = zoom fill
    0 = zoom real
    BackSpace = zoom optimal
    Alt+s = scale
    Alt+z = keep_zoom
    bracketleft = rotate_left
    bracketright = rotate_right
    m = flip_vertical
    Shift+m = flip_horizontal
    a = antialiasing
    r = reload
    i = info
    Shift+Delete = exec rm -f "%"; skip_file
    Escape = exit
    q = exit
    # Mouse related
    ScrollLeft = step_right 5
    ScrollRight = step_left 5
    ScrollUp = step_up 5
    ScrollDown = step_down 5
    Ctrl+ScrollUp = zoom +10
    Ctrl+ScrollDown = zoom -10
    Shift+ScrollUp = prev_file
    Shift+ScrollDown = next_file
    Alt+ScrollUp = prev_frame
    Alt+ScrollDown = next_frame
    
    [keys.gallery]
    F1 = help
    Home = first_file
    End = last_file
    h = step_left
    l = step_right
    k = step_up
    j = step_down
    Ctrl+u = page_up
    Ctrl+d = page_down
    c = skip_file
    f = fullscreen
    Return = mode
    a = antialiasing
    r = reload
    i = info
    Shift+Delete = exec rm -f "%"; skip_file
    Escape = exit
    q = exit
    # Mouse related
    ScrollLeft = step_right
    ScrollRight = step_left
    ScrollUp = step_up
    ScrollDown = step_down
  '';

}
