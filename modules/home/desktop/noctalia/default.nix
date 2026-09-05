{ config, ... }:

{
  programs.noctalia = {
    enable = true;
    systemd.enable = true;

    settings = {
      bar."default" = {
        position = "left";
        scale = 1.1;
        thickness = 44;
        widget_spacing = 14;
        background_opacity = config.stylix.opacity.desktop;
        start = [ "launcher" "wallpaper" "clock" "notifications" "media" "active_window" ];
        center = [ "workspaces" "privacy" ];
        end = [ "tray" "clipboard" "brightness" "battery" "control-center" "group:g1" "session" ];
        capsule_group = [{
          enabled = true;
          id = "g1";
          members = [ "network" "bluetooth" "volume" ];
        }];
      };

      accessibility.ui_scale = 1.1;
      backdrop.enabled = true;
      brightness.minimum_brightness = 0.01;
      nightlight.enabled = true;
      notification = {
        history_retention_hours = 72;
        position = "top_center";
      };
      osd = {
        position = "bottom_center";
        position_vertical = "bottom_center";
      };
      shell = {
        launcher.show_app_actions = true;
        animation.speed = 1.5;
        panel.launcher_placement = "attached";
        launch_apps_as_systemd_services = true;
        niri_overview_type_to_launch_enabled = true;
        session = {
          grid = true;
          grid_columns = 1;
          actions = [
            {
              action = "lock";
              countdown_seconds = 0;
              enabled = true;
              shortcut = "l";
              variant = "default";
            }
            {
              action = "logout";
              countdown_seconds = 0;
              enabled = true;
              shortcut = "x";
              variant = "default";
            }
            {
              action = "lock_and_suspend";
              countdown_seconds = 1;
              enabled = true;
              label = "Suspend";
              shortcut = "s";
              variant = "default";
            }
            {
              action = "reboot";
              countdown_seconds = 1;
              enabled = true;
              shortcut = "r";
              variant = "default";
            }
            {
              action = "shutdown";
              countdown_seconds = 1;
              enabled = true;
              shortcut = "p";
              variant = "destructive";
            }
          ];
        };
      };
      theme.templates = {
        enable_builtin_templates = false;
        enable_community_templates = false;
      };
      widget = {
        clock.vertical_format = "{:%H\\n%M\\n%a\\n%d\\n%m}";
        launcher.glyph = "grid-dots";
        media.hide_when_no_media = true;
        network.show_label = false;
        notifications.hide_when_no_unread = true;
        privacy.hide_inactive = true;
        workspaces.show_labels = false;
      };
    };
  };
}
