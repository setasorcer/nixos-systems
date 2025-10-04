{ config, lib, ... }:

let
  cfg = config.de.decorations;
in
{
  options.de.decorations = {
    enabled = lib.mkOption {
      default = true;
      description = ''Enable decorations for Hyprland'';
    };
  };
  config = {
    wayland.windowManager.hyprland.settings = {
      decoration = {
        rounding = 8;

        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = cfg.enabled;
          range = 100;
          render_power = 2;
          color = lib.mkForce "rgba(1a1a1a66)";
	  offset = "0 30";
	  scale = 0.96;
        };

        blur = {
          enabled = cfg.enabled;
          size = 16;
          passes = 2;
	  vibrancy_darkness = 2.0;
        };
      };

      animations = {
	enabled = cfg.enabled;
        bezier = "myBezier, 0.3, 0, 0, 1";
        animation = [
          "layers, 1, 3, default"
          "windows, 1, 5, myBezier"
          "windowsOut, 1, 5, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default, slidevert"
          "specialWorkspace, 1, 6, default, fade"
        ];
      };
    };
  };
}
