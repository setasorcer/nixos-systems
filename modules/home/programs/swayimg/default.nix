{ config, ... }:

{

  programs.swayimg = {
    enable = true;
    initLua = ''
--------------------------------------------------------------------------------
-- General config
--------------------------------------------------------------------------------
swayimg.mode = "viewer"                 -- mode at startup
swayimg.antialiasing = true             -- anti-aliasing
swayimg.decoration = true               -- window title/buttons/borders
swayimg.overlay = false                    -- window overlay mode
swayimg.exif_orientation = true            -- image orientation by EXIF
swayimg.dnd_button = "MouseRight"          -- drag-and-drop mouse button

-- Format specific parameters
swayimg.set_format_params('raw', { camera_wb = true }) -- use camera white balance

--------------------------------------------------------------------------------
-- Image list configuration
--------------------------------------------------------------------------------
swayimg.imagelist.order = "numeric"     -- list order
swayimg.imagelist.reverse = false       -- reverse order
swayimg.imagelist.recursive = false     -- recursive directory reading
swayimg.imagelist.adjacent = true       -- open all files in the directory (yes)
swayimg.imagelist.fsmon = true          -- enable file system monitoring

--------------------------------------------------------------------------------
-- Text overlay configuration
--------------------------------------------------------------------------------
swayimg.text.visible = true             -- show on startup
swayimg.text.font = "Inconsolata Nerd Font Propo" -- font name
swayimg.text.size = 18                  -- font size in pixels
swayimg.text.padding = 10               -- padding from window edge
swayimg.text.color = 0xFF${config.lib.stylix.colors.base07}    -- font color
swayimg.text.background = 0xE6${config.lib.stylix.colors.base00} -- background color
swayimg.text.shadow = 0xCC${config.lib.stylix.colors.base00}   -- shadow color
swayimg.text.timeout = 5                -- info timeout (seconds)
swayimg.text.status_timeout = 3         -- status message timeout (seconds)

--------------------------------------------------------------------------------
-- Image viewer mode
--------------------------------------------------------------------------------
swayimg.viewer.default_scale = "optimal"    -- default image scale
swayimg.viewer.default_position = "center"  -- default image position
swayimg.viewer.autocenter = true            -- fix position of the image on the window surface
swayimg.viewer.loop = true                  -- enable image list loop mode
swayimg.viewer.preload = 1                  -- number of images to preload
swayimg.viewer.history = 1                  -- number of images in history cache
swayimg.viewer.set_window_background(0xE6${config.lib.stylix.colors.base00}) -- window background color

-- Display scheme for viewer mode - position = content
-- top_left: +name,+format,+filesize,+imagesize
swayimg.viewer.set_text("topleft", {
  "File:\t{name}",
  "Format:\t{format}",
  "File size:\t{sizehr}",
  "Image size:\t{frame.width}x{frame.height}"
})
-- top_right: index
swayimg.viewer.set_text("topright", {
  "Image:\t{list.index} of {list.total}"
})
-- bottom_left: scale,frame
swayimg.viewer.set_text("bottomleft", {
  "Scale:\t{scale}",
  "Frame:\t{frame.index} of {frame.total}"
})
-- bottom_right: status
swayimg.viewer.set_text("bottomright", {
  "{status}"
})

-- exit from application
swayimg.viewer.on_key("Escape", function()
  swayimg.exit()
end)
swayimg.viewer.on_key("q", function()
  swayimg.exit()
end)

-- switch to gallery mode
swayimg.viewer.on_key("Return", function()
  swayimg.mode = "gallery"
end)

-- toggle fullscreen
swayimg.viewer.on_key("f", function()
  swayimg.fullscreen = not swayimg.fullscreen
end)

-- toggle anti-aliasing
swayimg.viewer.on_key("a", function()
  swayimg.antialiasing = not swayimg.antialiasing
end)

-- show/hide text overlay
swayimg.viewer.on_key("i", function()
  swayimg.text.visible = not swayimg.text.visible
end)

-- rotate image
swayimg.viewer.on_key("bracketright", function()
  swayimg.viewer.rotate(90)
end)
swayimg.viewer.on_key("bracketleft", function()
  swayimg.viewer.rotate(270)
end)

-- flip image
swayimg.viewer.on_key("m", function()
  swayimg.viewer.flip_vertical()
end)
swayimg.viewer.on_key("Shift+m", function()
  swayimg.viewer.flip_horizontal()
end)

-- zoom operations
swayimg.viewer.on_key("equal", function()
  swayimg.viewer.scale = swayimg.viewer.scale + swayimg.viewer.scale / 10
end)
swayimg.viewer.on_key("plus", function()
  swayimg.viewer.scale = swayimg.viewer.scale + swayimg.viewer.scale / 10
end)
swayimg.viewer.on_key("minus", function()
  swayimg.viewer.scale = swayimg.viewer.scale - swayimg.viewer.scale / 10
end)

-- zoom to specific modes
swayimg.viewer.on_key("w", function()
  swayimg.viewer.scale = "width"
end)
swayimg.viewer.on_key("Shift+w", function()
  swayimg.viewer.scale = "height"
end)
swayimg.viewer.on_key("z", function()
  swayimg.viewer.scale = "fit"
end)
swayimg.viewer.on_key("Shift+z", function()
  swayimg.viewer.scale = "fill"
end)
swayimg.viewer.on_key("0", function()
  swayimg.viewer.scale = 1.0
end)
swayimg.viewer.on_key("BackSpace", function()
  swayimg.viewer.scale = "optimal"
end)

-- toggle keep_zoom
swayimg.viewer.on_key("Alt+z", function()
  -- LUA doesn't have direct keep_zoom, approximate by toggling scale setting
  swayimg.viewer.reset()
end)
-- toggle scale
swayimg.viewer.on_key("Alt+s", function()
  swayimg.viewer.reset()
end)

-- reload image
swayimg.viewer.on_key("r", function()
  swayimg.viewer.open("reload")
end)

-- image navigation
swayimg.viewer.on_key("n", function()
  swayimg.viewer.open("next")
end)
swayimg.viewer.on_key("Space", function()
  swayimg.viewer.open("next")
end)
swayimg.viewer.on_key("p", function()
  swayimg.viewer.open("prev")
end)
swayimg.viewer.on_key("g", function()
  swayimg.viewer.open("first")
end)
swayimg.viewer.on_key("Shift+g", function()
  swayimg.viewer.open("last")
end)
swayimg.viewer.on_key("Shift+r", function()
  swayimg.viewer.open("random")
end)

-- directory navigation
swayimg.viewer.on_key("d", function()
  -- approximate: switch to gallery and scroll to next directory
  swayimg.viewer.open("next")
end)
swayimg.viewer.on_key("Shift+d", function()
  swayimg.viewer.open("prev")
end)

-- frame navigation (for animated images)
swayimg.viewer.on_key("o", function()
  swayimg.viewer.frame = swayimg.viewer.frame + 1
end)
swayimg.viewer.on_key("Shift+o", function()
  local frame = swayimg.viewer.frame
  if frame > 0 then
    swayimg.viewer.frame = frame - 1
  end
end)

-- skip file (remove from list)
swayimg.viewer.on_key("c", function()
  local img = swayimg.viewer.get_image()
  if img then
    swayimg.imagelist.remove(img.path)
  end
end)

-- slideshow
swayimg.viewer.on_key("Shift+s", function()
  swayimg.mode = "slideshow"
end)

-- animation toggle
swayimg.viewer.on_key("Ctrl+Space", function()
  -- Toggle animation if supported
  swayimg.viewer.frame = 0
end)

-- delete file and skip
swayimg.viewer.on_key("Shift+Delete", function()
  local img = swayimg.viewer.get_image()
  if img then
    os.execute("rm -f \"" .. img.path .. "\"")
    local img2 = swayimg.viewer.get_image()
    if img2 then
      swayimg.imagelist.remove(img2.path)
    end
  end
end)

-- move image across the window
swayimg.viewer.on_key("h", function()
  local pos = swayimg.viewer.get_position()
  swayimg.viewer.set_abs_position(pos.x + 10, pos.y)
end)
swayimg.viewer.on_key("l", function()
  local pos = swayimg.viewer.get_position()
  swayimg.viewer.set_abs_position(pos.x - 10, pos.y)
end)
swayimg.viewer.on_key("k", function()
  local pos = swayimg.viewer.get_position()
  swayimg.viewer.set_abs_position(pos.x, pos.y + 10)
end)
swayimg.viewer.on_key("j", function()
  local pos = swayimg.viewer.get_position()
  swayimg.viewer.set_abs_position(pos.x, pos.y - 10)
end)

-- move image across the window (mouse/touchpad)
swayimg.viewer.on_mouse("ScrollUp", function()
  local pos = swayimg.viewer.get_position()
  swayimg.viewer.set_abs_position(pos.x, pos.y - 5)
end)
swayimg.viewer.on_mouse("ScrollDown", function()
  local pos = swayimg.viewer.get_position()
  swayimg.viewer.set_abs_position(pos.x, pos.y + 5)
end)
swayimg.viewer.on_mouse("ScrollLeft", function()
  local pos = swayimg.viewer.get_position()
  swayimg.viewer.set_abs_position(pos.x - 5, pos.y)
end)
swayimg.viewer.on_mouse("ScrollRight", function()
  local pos = swayimg.viewer.get_position()
  swayimg.viewer.set_abs_position(pos.x + 5, pos.y)
end)

-- zoom in/out (mouse/touchpad)
swayimg.viewer.on_mouse("Ctrl+ScrollUp", function()
  local mouse = swayimg.get_mouse_pos()
  local scale = swayimg.viewer.scale
  swayimg.viewer.set_abs_scale(scale + scale / 10, mouse.x, mouse.y)
end)
swayimg.viewer.on_mouse("Ctrl+ScrollDown", function()
  local mouse = swayimg.get_mouse_pos()
  local scale = swayimg.viewer.scale
  swayimg.viewer.set_abs_scale(scale - scale / 10, mouse.x, mouse.y)
end)

-- next/prev file (mouse/touchpad)
swayimg.viewer.on_mouse("Shift+ScrollUp", function()
  swayimg.viewer.open("prev")
end)
swayimg.viewer.on_mouse("Shift+ScrollDown", function()
  swayimg.viewer.open("next")
end)

-- next/prev frame (mouse/touchpad)
swayimg.viewer.on_mouse("Alt+ScrollUp", function()
  local frame = swayimg.viewer.frame
  if frame > 0 then
    swayimg.viewer.frame = frame - 1
  end
end)
swayimg.viewer.on_mouse("Alt+ScrollDown", function()
  swayimg.viewer.frame = swayimg.viewer.frame + 1
end)

-- help
swayimg.viewer.on_key("F1", function()
  -- Show help if supported
  swayimg.text.visible = true
end)

-- Open with swayimg exec for SIGUSR1 and SIGUSR2
-- Note: signal handling requires external configuration
-- SIGUSR1 = reload
-- SIGUSR2 = next_file

--------------------------------------------------------------------------------
-- Gallery mode
--------------------------------------------------------------------------------
swayimg.gallery.thumb_size = 200            -- thumbnail size in pixels
swayimg.gallery.aspect = "fill"             -- fill the entire tile with thumbnail
swayimg.gallery.padding_size = 5            -- default padding
swayimg.gallery.border_size = 5             -- border size for selected thumbnail
swayimg.gallery.border_color = 0xE6${config.lib.stylix.colors.base00}  -- border color for selected thumbnail
swayimg.gallery.selected_scale = 1.15       -- normal scale
swayimg.gallery.selected_color = 0xE6${config.lib.stylix.colors.base00} -- background color for selected tile
swayimg.gallery.unselected_color = 0xE6${config.lib.stylix.colors.base00} -- background color of unselected thumbnail
swayimg.gallery.window_color = 0xE6${config.lib.stylix.colors.base00}   -- window background color
swayimg.gallery.pinch_factor = 100.0          -- pinch gesture factor
swayimg.gallery.hover = true                -- enable mouse following
swayimg.gallery.cache = 100                 -- thumbnail cache size
swayimg.gallery.preload = false               -- preloading invisible thumbnails
swayimg.gallery.embedded_thumb = true       -- use embedded thumbnails
swayimg.gallery.pstore = true               -- enable persistent storage for thumbnails

-- Display scheme for gallery mode - position = content
swayimg.gallery.set_text("topleft", { "" })           -- none
swayimg.gallery.set_text("topright", { "" })          -- none
swayimg.gallery.set_text("bottomleft", { "" })        -- none
swayimg.gallery.set_text("bottomright", {
  "{name}",
  "{status}"
})

-- exit from application
swayimg.gallery.on_key("Escape", function()
  swayimg.exit()
end)
swayimg.gallery.on_key("q", function()
  swayimg.exit()
end)

-- switch to viewer mode
swayimg.gallery.on_key("Return", function()
  swayimg.mode = "viewer"
end)

-- toggle fullscreen
swayimg.gallery.on_key("f", function()
  swayimg.fullscreen = not swayimg.fullscreen
end)

-- toggle anti-aliasing
swayimg.gallery.on_key("a", function()
  swayimg.antialiasing = not swayimg.antialiasing
end)

-- show/hide text overlay
swayimg.gallery.on_key("i", function()
  swayimg.text.visible = not swayimg.text.visible
end)

-- reload
swayimg.gallery.on_key("r", function()
  -- Force gallery refresh
  swayimg.gallery.select("first")
end)

-- skip file (remove from list)
swayimg.gallery.on_key("c", function()
  local img = swayimg.gallery.get_image()
  if img then
    swayimg.imagelist.remove(img.path)
  end
end)

-- delete file and skip
swayimg.gallery.on_key("Shift+Delete", function()
  local img = swayimg.gallery.get_image()
  if img then
    os.execute("rm -f \"" .. img.path .. "\"")
    local img2 = swayimg.gallery.get_image()
    if img2 then
      swayimg.imagelist.remove(img2.path)
    end
  end
end)

-- select another thumbnail
swayimg.gallery.on_key("home", function()
  swayimg.gallery.select("first")
end)
swayimg.gallery.on_key("end", function()
  swayimg.gallery.select("last")
end)
swayimg.gallery.on_key("h", function()
  swayimg.gallery.select("left")
end)
swayimg.gallery.on_key("l", function()
  swayimg.gallery.select("right")
end)
swayimg.gallery.on_key("k", function()
  swayimg.gallery.select("up")
end)
swayimg.gallery.on_key("j", function()
  swayimg.gallery.select("down")
end)
swayimg.gallery.on_key("Ctrl+u", function()
  swayimg.gallery.select("pgup")
end)
swayimg.gallery.on_key("Ctrl+d", function()
  swayimg.gallery.select("pgdown")
end)

-- select another thumbnail (mouse/touchpad)
swayimg.gallery.on_mouse("ScrollUp", function()
  swayimg.gallery.select("up")
end)
swayimg.gallery.on_mouse("ScrollDown", function()
  swayimg.gallery.select("down")
end)
swayimg.gallery.on_mouse("ScrollLeft", function()
  swayimg.gallery.select("left")
end)
swayimg.gallery.on_mouse("ScrollRight", function()
  swayimg.gallery.select("right")
end)

-- help
swayimg.gallery.on_key("F1", function()
  swayimg.text.visible = true
end)

--------------------------------------------------------------------------------
-- Slide show mode (from viewer config except where noted)
--------------------------------------------------------------------------------
swayimg.slideshow.timeout = 3               -- slideshow time from viewer config
swayimg.slideshow.history = 0               -- disable history for slideshow (default)
swayimg.slideshow.default_scale = "optimal" -- use viewer's scale setting
swayimg.slideshow.set_window_background(0x${config.lib.stylix.colors.base00}E6)

-- switch to viewer mode
swayimg.slideshow.on_key("s", function()
  swayimg.mode = "viewer"
end)
    '';
  };
}
