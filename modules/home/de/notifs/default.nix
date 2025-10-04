{ ... }:

{
  #imports = [ ./style.nix ];
  services.swaync = {
    enable = true;
    settings = {
      positionX = "center";
      positionY = "top";
      layer = "overlay";
      layer-shell = true;
      control-center-positionX = "center";
      control-center-positionY = "top";
      control-center-layer = "overlay";
      control-center-margin-top = 5;
      fit-to-screen = false;
      control-center-width = 480;
      control-center-height = 800;
      notification-window-width = 480;
      widgets = [
        "title"
        "buttons-grid"
        "mpris"
        "notifications"
      ];
      widget-config = {
        title = {
          text = "Dashboard";
          clear-all-button = false;
        };
        buttons-grid = {
          actions = [
            {
              label = "⏻";
              command = "rofi -show power-menu -modi power-menu:rofi-power-menu";
            }
            {
              label = "";
              type = "toggle";
              command = "sh -c '[[ $SWAYNC_TOGGLE_STATE == true ]] && swaync-client -dn || swaync-client -df'";
              update-command = "sh -c '[[ $(swaync-client -D) == \"true\" ]] && echo true || echo false'";
            }
            {
              label = "󰎟";
              command = "swaync-client -C";
            }
          ];
        };
      };
    };
  };

  # OSD (Volume, backlight notifs)
  services.avizo = {
    enable = true;
    settings = {
      default = {
        time = 1.5;
        fade-in = 0.1;
        fade-out = 0.2;
        border-width = 0;
      };
    };
  };
}
