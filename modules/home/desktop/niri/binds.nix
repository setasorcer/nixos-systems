{ config, pkgs, ... }:

let
  noctalia = cmd: [
    "noctalia-shell" "ipc" "call"
  ] ++ (pkgs.lib.splitString " " cmd);
in
{
  programs.niri.settings.binds = with config.lib.niri.actions; {
    "Mod+Shift+Slash".action = show-hotkey-overlay;
    
    "Mod+Return".action = spawn "foot";
    "Mod+Return".repeat = false;
    "Mod+R".action = spawn "foot" "yazi";
    "Mod+R".repeat = false;
    "Mod+D".action.spawn = noctalia "launcher toggle";
    "Mod+D".repeat = false;
    "Mod+0".action = spawn "foot" "bc" "-lq";
    "Mod+0".repeat = false;
    "Mod+BackSpace".action.spawn = noctalia "sessionMenu toggle";
    "Mod+BackSpace".repeat = false;
    "Mod+Alt+L".action.spawn = noctalia "lockScreen lock";
    "Mod+Alt+L".repeat = false;
    "Mod+N".action.spawn = noctalia "notifications toggleHistory";
    "Mod+N".repeat = false;
    
    "XF86AudioRaiseVolume".action.spawn = noctalia "volume increase";
    "XF86AudioRaiseVolume".allow-when-locked = true;
    "XF86AudioLowerVolume".action.spawn = noctalia "volume decrease";
    "XF86AudioLowerVolume".allow-when-locked = true;
    "XF86AudioMute".action.spawn = noctalia "volume muteOutput";
    "XF86AudioMute".allow-when-locked = true;
    "XF86AudioMicMute".action.spawn = noctalia "volume muteInput";
    "XF86AudioMicMute".allow-when-locked = true;
    "XF86MonBrightnessUp".action.spawn = noctalia "brightness increase";
    "XF86MonBrightnessUp".allow-when-locked = true;
    "XF86MonBrightnessDown".action.spawn = noctalia "brightness decrease";
    "XF86AudioPlay".action.spawn = noctalia "media playPause";
    "XF86AudioStop".action.spawn = noctalia "media pause";
    "XF86AudioPrev".action.spawn = noctalia "media previous";
    "XF86AudioNext".action.spawn = noctalia "media next";
    "Mod+Down".action.spawn = noctalia "media playPause";
    "Mod+Up".action.spawn = noctalia "media pause";
    "Mod+Left".action.spawn = noctalia "media previous";
    "Mod+Right".action.spawn = noctalia "media next";

    "Mod+O".action = toggle-overview;
    "Mod+O".repeat = false;
    
    "Mod+Q".action = close-window;
    
    "Mod+H".action = focus-column-left;
    "Mod+J".action = focus-window-or-workspace-down;
    "Mod+K".action = focus-window-or-workspace-up;
    "Mod+L".action = focus-column-right;
    
    "Mod+Shift+H".action = move-column-left;
    "Mod+Shift+J".action = move-window-down-or-to-workspace-down;
    "Mod+Shift+K".action = move-window-up-or-to-workspace-up;
    "Mod+Shift+L".action = move-column-right;
    
    "Mod+I".action = focus-column-first;
    "Mod+A".action = focus-column-last;
    "Mod+Shift+I".action = move-column-to-first;
    "Mod+Shift+A".action = move-column-to-last;
    
    "Mod+Ctrl+J".action = move-workspace-down;
    "Mod+Ctrl+K".action = move-workspace-up;

    "Mod+WheelScrollDown".action = focus-workspace-down;
    "Mod+WheelScrollDown".cooldown-ms = 150;
    "Mod+WheelScrollUp".action = focus-workspace-up;
    "Mod+WheelScrollUp".cooldown-ms = 150;
    "Mod+Ctrl+WheelScrollDown".action = move-column-to-workspace-down;
    "Mod+Ctrl+WheelScrollDown".cooldown-ms = 150;
    "Mod+Ctrl+WheelScrollUp".action = move-column-to-workspace-up;
    "Mod+Ctrl+WheelScrollUp".cooldown-ms = 150;
    "Mod+WheelScrollRight".action = focus-column-right;
    "Mod+WheelScrollLeft".action = focus-column-left;
    "Mod+Ctrl+WheelScrollRight".action = move-column-right;
    "Mod+Ctrl+WheelScrollLeft".action = move-column-left;
    "Mod+Shift+WheelScrollDown".action = focus-column-right;
    "Mod+Shift+WheelScrollUp".action = focus-column-left;
    "Mod+Ctrl+Shift+WheelScrollDown".action = move-column-right;
    "Mod+Ctrl+Shift+WheelScrollUp".action = move-column-left;
    
    "Mod+1".action.focus-workspace = 1;
    "Mod+2".action.focus-workspace = 2;
    "Mod+3".action.focus-workspace = 3;
    "Mod+4".action.focus-workspace = 4;
    "Mod+5".action.focus-workspace = 5;
    "Mod+6".action.focus-workspace = 6;
    "Mod+7".action.focus-workspace = 7;
    "Mod+8".action.focus-workspace = 8;
    "Mod+9".action.focus-workspace = 9;
    "Mod+Shift+1".action.move-column-to-workspace = 1;
    "Mod+Shift+2".action.move-column-to-workspace = 2;
    "Mod+Shift+3".action.move-column-to-workspace = 3;
    "Mod+Shift+4".action.move-column-to-workspace = 4;
    "Mod+Shift+5".action.move-column-to-workspace = 5;
    "Mod+Shift+6".action.move-column-to-workspace = 6;
    "Mod+Shift+7".action.move-column-to-workspace = 7;
    "Mod+Shift+8".action.move-column-to-workspace = 8;
    "Mod+Shift+9".action.move-column-to-workspace = 9;
    
    # The following binds move the focused window in and out of a column.
    # If the window is alone, they will consume it into the nearby column to the side.
    # If the window is already in a column, they will expel it out.
    "Mod+BracketLeft".action =  consume-or-expel-window-left;
    "Mod+BracketRight".action = consume-or-expel-window-right;
    # Consume one window from the right to the bottom of the focused column.
    "Mod+Comma".action =  consume-window-into-column;
    # Expel the bottom window from the focused column to the right.
    "Mod+Period".action = expel-window-from-column;
    
    "Mod+Semicolon".action = switch-preset-column-width;
    "Mod+Apostrophe".action = switch-preset-window-height;
    "Mod+Shift+Apostrophe".action = reset-window-height;
    "Mod+M".action = maximize-column;
    "Mod+F".action = fullscreen-window;
    
    # Expand the focused column to space not taken up by other fully visible columns.
    # Makes the column "fill the rest of the space".
    "Mod+Ctrl+F".action = expand-column-to-available-width;
    
    "Mod+C".action = center-column;
    "Mod+Ctrl+C".action = center-visible-columns;
    
    "Mod+V".action = toggle-window-floating;
    "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;
    
    "Mod+W".action = toggle-column-tabbed-display;
    
    "Shift+Print".action.screenshot = [ ];
    "Print".action.screenshot-screen = [ ];
    "Mod+Print".action.screenshot-window = [ ];
    
    "Mod+Escape".action = toggle-keyboard-shortcuts-inhibit;
    "Mod+Escape".allow-inhibiting = false;
    
    "XF86Tools".action = power-off-monitors;
    "XF86Favorites".action = power-off-monitors;
    "Shift+F12".action = power-off-monitors;
  };
}
