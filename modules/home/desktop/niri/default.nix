{ config, ... }:

{
  imports = [ 
    ./binds.nix
    ./layout.nix
    ./shell-binds.nix
  ];
  wayland.windowManager.niri = {
    enable = true;
    systemd.enable = true;

    settings = {
      input = {
        keyboard = {
          repeat-delay = 300;
          repeat-rate = 50;
        };

        touchpad = {
          tap = {};
          natural-scroll = {};
          accel-profile = "adaptive";
          scroll-method = "two-finger";
          tap-button-map = "left-right-middle";
          click-method = "clickfinger";
        };

        tablet = {
          map-to-output = "eDP-1";
        };

        mouse = {
          accel-profile = "flat";
        };

        warp-mouse-to-focus = {};
      };

      cursor.hide-after-inactive-ms = 3000;
      hotkey-overlay.skip-at-startup = {};
      screenshot-path = "${config.xdg.userDirs.pictures}/snaps/%Y-%m-%d-%H%M%S_niri.png";

      _children = [
        {
          window-rule._children = [
            { geometry-corner-radius = 8; }
            { clip-to-geometry = true; }
            { background-effect._children = [ { blur = true; } { xray = false; } ]; }
          ];
        }
        {
          window-rule._children = [
            { match._props = { app-id = "zen-beta"; title = "^Picture-in-Picture$"; }; }
            { open-floating = true; }
          ];
        }
        {
          window-rule._children = [
            { match._props = { app-id = "zen-beta"; title = "^.*Zen Browser$"; }; }
            { default-column-width.proportion = 2.0 / 3.0; }
          ];
        }
        {
          window-rule._children = [
            { match._props = { app-id = "vesktop"; title = ".*Discord.*$"; }; }
            { default-column-width.proportion = 1.0 / 3.0; }
          ];
        }
        {
          layer-rule._children = [
            { match._props = { namespace = "dms:blurwallpaper"; }; }
            { place-within-backdrop = true; }
          ];
        }
        {
          layer-rule._children = [
            { match._props = { namespace = "^noctalia-backdrop"; }; }
            { place-within-backdrop = true; }
          ];
        }
      ];
    };
  };
}
