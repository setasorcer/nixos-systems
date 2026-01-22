{ config, ... }:

{
  programs.niri.settings = {
    outputs = 
      let
        cfg = config.programs.niri.settings.outputs;
      in
      {
        "eDP-2" = {
          variable-refresh-rate = true;
          scale = 1.25;
          position.x = cfg."DP-4".mode.width / 10;
          position.y = cfg."DP-4".mode.height;
        };
        "DP-3" = {
          mode = {
            width = 2560;
            height = 1440;
          };
          position.x = 0;
          position.y = 0;
        };
        "DP-4" = {
          mode = {
            width = 2560;
            height = 1440;
          };
          position.x = 0;
          position.y = 0;
        };
      };

    prefer-no-csd = true;
    layout = {
      gaps = 16;
      center-focused-column = "on-overflow";
      always-center-single-column = true;

      preset-column-widths = [
        { proportion = 1.0 / 3.0; }
        { proportion = 1.0 / 2.0; }
        { proportion = 2.0 / 3.0; }
      ];

      default-column-width = { proportion = 1.0 / 2.0; };

      focus-ring = {
        width = 4;
        active.color = "#${config.stylix.base16Scheme.base0E}";
        inactive.color = "#${config.stylix.base16Scheme.base00}";
      };

      shadow = {
        enable = true;
        softness = 30;
        spread = 5;
        offset.x = 0;
        offset.y = 0;
        color = "#0007";
      };

      struts = {
        top = 8;
        bottom = 32;
        left = 32;
        right = 32;
      };
    };
  };
}
