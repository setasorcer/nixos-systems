{ config, ... }:

{
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    "$snapVars" = "-o ${config.home.homeDirectory}/pix/snaps";
    bind = [
      "$mod, return, exec, $term"
      "$mod, D, exec, rofi -show drun -show-icons -run-command \"uwsm app -- {cmd}\""
      "$mod, E, exec, rofi -show emoji -modi emoji"
      "$mod, N, exec, swaync-client -t -sw"
      "$mod SHIFT, D, exec, tessen"
      "$mod, R, exec, $term $fm"
      "$mod, W, exec, $web"
      "$mod, B, exec, pkill -SIGUSR1 waybar"

      ", Print, exec, hyprshot -m output -m active $snapVars"
      "SHIFT, Print, exec, hyprshot -m region $snapVars"
      "$mod, Print, exec, hyprshot -m window $snapVars"

      "$mod, F, fullscreen, 0"
      "$mod, Q, killactive"
      "$mod, backspace, exec, rofi -show power-menu -modi power-menu:rofi-power-menu"

      "$mod, space, layoutmsg, swapwithmaster master"
      "$mod, J, layoutmsg, cyclenext"
      "$mod, K, layoutmsg, cycleprev"
      "$mod, H, layoutmsg, mfact -0.05"
      "$mod, L, layoutmsg, mfact +0.05"
      "$mod SHIFT, U, fullscreen, 1"

      # Scratchpads
      "$mod, apostrophe, togglespecialworkspace, C" # calculator
      "$mod SHIFT, return, togglespecialworkspace, S" # terminal
      "$mod, M, togglespecialworkspace, M" # music
      # All the workspaces!
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"
      "$mod SHIFT, 1, movetoworkspacesilent, 1"
      "$mod SHIFT, 2, movetoworkspacesilent, 2"
      "$mod SHIFT, 3, movetoworkspacesilent, 3"
      "$mod SHIFT, 4, movetoworkspacesilent, 4"
      "$mod SHIFT, 5, movetoworkspacesilent, 5"
      "$mod SHIFT, 6, movetoworkspacesilent, 6"
      "$mod SHIFT, 7, movetoworkspacesilent, 7"
      "$mod SHIFT, 8, movetoworkspacesilent, 8"
      "$mod SHIFT, 9, movetoworkspacesilent, 9"
    ];

    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    bindel = [
      ",XF86Favorites, exec, chayang -d 2 && hyprctl dispatch dpms off" # T480 F12
      ",XF86AudioMedia, exec, chayang -d 2 && hyprctl dispatch dpms off" # FW13 F12
      "SHIFT, F12, exec, chayang -d 2 && hyprctl dispatch dpms off" # Universal F12
      ",XF86WakeUp, exec, dpms on"
      "CTRL, F12, exec, dpms on" # If above doesn't work

      # Use mpc instead because playerctl is buggy
      ",XF86AudioPlay, exec, mpc toggle"
      "$mod, Down, exec, mpc toggle"
      ",XF86AudioStop, exec, mpc stop"
      "$mod, Up, exec, mpc stop"
      ",XF86AudioPrev, exec, mpc prev"
      "$mod, Left, exec, mpc prev"
      ",XF86AudioNext, exec, mpc next"
      "$mod, Right, exec, mpc next"

      ",XF86AudioRaiseVolume, exec, volumectl -u up"
      ",XF86AudioLowerVolume, exec, volumectl -u down"
      ",XF86AudioMute, exec, volumectl toggle-mute"
      ",XF86AudioMicMute, exec, volumectl -m toggle-mute"

      ",XF86MonBrightnessUp, exec, lightctl up"
      ",XF86MonBrightnessDown, exec, lightctl down"
    ];

    # Used for when docking a laptop.
    # BUG: If closing the lid before plugging in dock, a workspace will not transfer to the new monitor.
    # Temporary fix is to physically open and close the lid. Workspaces will then appear.
    bindl = [
      ",switch:on:Lid Switch, exec, hyprctl keyword monitor 'eDP-1, disable'; loginctl lock-session"
      ",switch:off:Lid Switch, exec, hyprctl keyword monitor 'eDP-1, highrr, auto, 1.5, cm, auto'"
    ];
  };
}
