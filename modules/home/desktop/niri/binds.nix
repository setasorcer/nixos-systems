{ pkgs, ... }:

let
  dms = cmd: [
    "dms" "ipc" "call"
  ] ++ (pkgs.lib.splitString " " cmd);
in
{
  wayland.windowManager.niri.settings.binds = {
    "Mod+Shift+Slash".show-hotkey-overlay = {};

    "Mod+Return" = {
      _props.repeat = false;
      spawn = [ "foot" ];
    };
    "Mod+R" = {
      _props.repeat = false;
      spawn = [ "foot" "yazi" ];
    };
    "Mod+D" = {
      _props.repeat = false;
      spawn = dms "spotlight toggle";
    };
    "Mod+BackSpace" = {
      _props.repeat = false;
      spawn = dms "powermenu toggle";
    };
    "Mod+Alt+L" = {
      _props.repeat = false;
      spawn = dms "lock lock";
    };
    "Mod+N" = {
      _props.repeat = false;
      spawn = dms "notifications open";
    };
    "Mod+Shift+N" = {
      _props.repeat = false;
      spawn = dms "notifications notifications dismissAllPopups";
    };
    "Mod+B" = {
      _props.repeat = false;
      spawn = dms "control-center toggle";
    };

    "XF86AudioRaiseVolume" = {
      _props.allow-when-locked = true;
      spawn = dms "audio increment 5";
    };
    "XF86AudioLowerVolume" = {
      _props.allow-when-locked = true;
      spawn = dms "audio decrement 5";
    };
    "XF86AudioMute" = {
      _props.allow-when-locked = true;
      spawn = dms "audio mute";
    };
    "XF86AudioMicMute" = {
      _props.allow-when-locked = true;
      spawn = dms "audio micmute";
    };
    "XF86MonBrightnessUp" = {
      _props.allow-when-locked = true;
      spawn = dms "brightness increment 5 backlight:intel_backlight";
    };
    "XF86MonBrightnessDown" = {
      _props.allow-when-locked = true;
      spawn = dms "brightness decrement 5 backlight:intel_backlight";
    };
    "XF86AudioPlay".spawn = dms "mpris playPause";
    "XF86AudioStop".spawn = dms "mpris pause";
    "XF86AudioPrev".spawn = dms "mpris previous";
    "XF86AudioNext".spawn = dms "mpris next";
    "Mod+Down".spawn = dms "mpris playPause";
    "Mod+Up".spawn = dms "mpris pause";
    "Mod+Left".spawn = dms "mpris previous";
    "Mod+Right".spawn = dms "mpris next";

    "Mod+O" = {
      _props.repeat = false;
      toggle-overview = {};
    };
    "Mod+Q".close-window = {};

    "Mod+H".focus-column-left = {};
    "Mod+J".focus-window-or-workspace-down = {};
    "Mod+K".focus-window-or-workspace-up = {};
    "Mod+L".focus-column-right = {};
    
    "Mod+Shift+H".move-column-left = {};
    "Mod+Shift+J".move-window-down-or-to-workspace-down = {};
    "Mod+Shift+K".move-window-up-or-to-workspace-up = {};
    "Mod+Shift+L".move-column-right = {};
    
    "Mod+I".focus-column-first = {};
    "Mod+A".focus-column-last = {};
    "Mod+Shift+I".move-column-to-first = {};
    "Mod+Shift+A".move-column-to-last = {};
    
    "Mod+Ctrl+J".move-workspace-down = {};
    "Mod+Ctrl+K".move-workspace-up = {};

    "Mod+WheelScrollDown" = {
      _props.cooldown-ms = 150;
      focus-workspace-down = {};
    };
    "Mod+WheelScrollUp" = {
      _props.cooldown-ms = 150;
      focus-workspace-up = {};
    };
    "Mod+Ctrl+WheelScrollDown" = {
      _props.cooldown-ms = 150;
      move-column-to-workspace-down = {};
    };
    "Mod+Ctrl+WheelScrollUp" = {
      _props.cooldown-ms = 150;
      move-column-to-workspace-up = {};
    };
    "Mod+WheelScrollRight".focus-column-right = {};
    "Mod+WheelScrollLeft".focus-column-left = {};
    "Mod+Ctrl+WheelScrollRight".move-column-right = {};
    "Mod+Ctrl+WheelScrollLeft".move-column-left = {};
    "Mod+Shift+WheelScrollDown".focus-column-right = {};
    "Mod+Shift+WheelScrollUp".focus-column-left = {};
    "Mod+Ctrl+Shift+WheelScrollDown".move-column-right = {};
    "Mod+Ctrl+Shift+WheelScrollUp".move-column-left = {};
    
    "Mod+1".focus-workspace = 1;
    "Mod+2".focus-workspace = 2;
    "Mod+3".focus-workspace = 3;
    "Mod+4".focus-workspace = 4;
    "Mod+5".focus-workspace = 5;
    "Mod+6".focus-workspace = 6;
    "Mod+7".focus-workspace = 7;
    "Mod+8".focus-workspace = 8;
    "Mod+9".focus-workspace = 9;
    "Mod+Shift+1".move-column-to-workspace = 1;
    "Mod+Shift+2".move-column-to-workspace = 2;
    "Mod+Shift+3".move-column-to-workspace = 3;
    "Mod+Shift+4".move-column-to-workspace = 4;
    "Mod+Shift+5".move-column-to-workspace = 5;
    "Mod+Shift+6".move-column-to-workspace = 6;
    "Mod+Shift+7".move-column-to-workspace = 7;
    "Mod+Shift+8".move-column-to-workspace = 8;
    "Mod+Shift+9".move-column-to-workspace = 9;
    
    # The following binds move the focused window in and out of a column.
    # If the window is alone, they will consume it into the nearby column to the side.
    # If the window is already in a column, they will expel it out.
    "Mod+BracketLeft".consume-or-expel-window-left = {};
    "Mod+BracketRight".consume-or-expel-window-right = {};
    # Consume one window from the right to the bottom of the focused column.
    "Mod+Comma". consume-window-into-column = {};
    # Expel the bottom window from the focused column to the right.
    "Mod+Period".expel-window-from-column = {};
    
    "Mod+Semicolon".switch-preset-column-width = {};
    "Mod+Apostrophe".switch-preset-window-height = {};
    "Mod+Shift+Apostrophe".reset-window-height = {};
    "Mod+M".maximize-column = {};
    "Mod+F".fullscreen-window = {};
    
    # Expand the focused column to space not taken up by other fully visible columns.
    # Makes the column "fill the rest of the space".
    "Mod+Ctrl+F".expand-column-to-available-width = {};
    
    "Mod+C".center-column = {};
    "Mod+Ctrl+C".center-visible-columns = {};
    
    "Mod+Shift+V".toggle-window-floating = {};
    "Mod+V".switch-focus-between-floating-and-tiling = {};
    
    "Mod+W".toggle-column-tabbed-display = {};
    
    "Shift+Print".screenshot = {};
    "Print".screenshot-screen = {};
    "Mod+Print".spawn = dms "screenRecorder toggleRecording";
    
    "Mod+Escape" = {
      _props.allow-inhibiting = false;
      toggle-keyboard-shortcuts-inhibit = {};
    };
    
    "XF86Tools".power-off-monitors = {};
    "XF86AudioMedia".power-off-monitors = {};
    "Shift+F12".power-off-monitors = {};
  };
}
