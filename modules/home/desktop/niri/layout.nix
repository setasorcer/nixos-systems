{ config, ... }:

{
  wayland.windowManager.niri.settings = {
    _children = [
      { output = { _args = ["DP-1"]; position._props = { x = 0; y = 0; }; mode = "3440x1440"; }; }
      { output = { _args = ["eDP-1"]; scale = 1; mode = "1920x1200"; variable-refresh-rate._props = { on-demand = false; }; }; }
      { output = { _args = ["eDP-2"]; scale = 1.25; position._props = { x = 344; y = 1440; }; variable-refresh-rate._props = { on-demand = false; }; }; }
    ];

    prefer-no-csd = {};

    layout = {
      gaps = 16;
      center-focused-column = "on-overflow";
      always-center-single-column = {};

      preset-column-widths._children = [
        { proportion = 1.0 / 3.0; }
        { proportion = 1.0 / 2.0; }
        { proportion = 2.0 / 3.0; }
      ];

      default-column-width.proportion = 1.0 / 2.0;

      focus-ring = {
        width = 4;
        active-color = "${config.lib.stylix.colors.withHashtag.base0D}";
        inactive-color = "${config.lib.stylix.colors.withHashtag.base00}";
      };

      shadow = {
        on = {};
        softness = 30;
        spread = 5;
        offset._props = { x = 0; y = 0; };
        color = "#0007";
      };

      struts = {
        top = 8;
        bottom = 8;
        left = 32;
        right = 32;
      };
    };
  };
}
