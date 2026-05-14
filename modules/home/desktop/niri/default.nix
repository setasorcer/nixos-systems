{ lib, inputs, pkgs, ... }:

{
  imports = [ 
    inputs.niri.homeModules.niri
    ./binds.nix
    ./layout.nix
  ];
  programs.niri = 
    let
      niriPkgs = inputs.niri-pkgs.packages.${pkgs.stdenv.hostPlatform.system};
    in
  {
    enable = true;
    package = niriPkgs.niri-unstable;
    settings = {
      xwayland-satellite.path = lib.getExe niriPkgs.xwayland-satellite-unstable;
      includes = lib.mkAfter [(./blur.kdl)];
      spawn-at-startup = [
          { argv = ["noctalia-shell"]; }
      ];

      input = {
        keyboard = {
          repeat-delay = 300;
          repeat-rate = 50;
        };

        touchpad = {
          tap = true;
          natural-scroll = true;
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

        warp-mouse-to-focus.enable = true;
      };

      cursor.hide-after-inactive-ms = 3000;
      hotkey-overlay.skip-at-startup = true;
      screenshot-path = "~/pix/snaps/%Y-%m-%d-%H%M%S_niri.png";

      window-rules = [
        {
          geometry-corner-radius =
            let
              r = 8.0;
            in
            {
              top-left = r;
              top-right = r;
              bottom-left = r;
              bottom-right = r;
            };
          clip-to-geometry = true;
        }
        {
          matches = [{ app-id = "zen-beta"; title = "^Picture-in-Picture$"; }];
          open-floating = true;
        }
        {
          matches = [{ app-id = "zen-beta"; title = "^.*Zen Browser$"; }];
          default-column-width.proportion = 2.0 / 3.0;
        }
        {
          matches = [{ app-id = "moe.launcher.an-anime-game-launcher"; title = "^An Anime Game Launcher$"; }];
          default-window-height.proportion = 1.0 / 2.0;
        }
	{
          matches = [{ app-id = "feishin"; }];
          default-column-width.proportion = 2.0 / 3.0;
	}
	{
          matches = [{ app-id = "vesktop"; title = ".*Discord.*$"; }];
          default-column-width.proportion = 1.0 / 3.0;
	}
        {
          matches = [{ app-id = "VirtualBox Machine"; }];
          default-column-width.proportion = 1.0;
        }
      ];

      layer-rules = [
        {
          matches = [{ namespace = "^noctalia-overview*"; }];
          place-within-backdrop = true;
        }
        {
          matches = [{ namespace = "^dms:blurwallpaper*"; }];
          place-within-backdrop = true;
        }
      ];
    };
  };
}
