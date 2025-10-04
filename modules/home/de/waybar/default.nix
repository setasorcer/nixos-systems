{ pkgs, config, host, ... }:

let
  bluetooth-toggle = pkgs.writeShellScript "blue-toggle.sh" ''
    STATUS=$(bluetoothctl show | grep "Powered" | awk '{print $2}')
    if [ "$STATUS" = "yes" ]; then
        bluetoothctl power off
    else
        bluetoothctl power on
    fi
  '';
in
{
  imports = [
    ./style.nix
  ];
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = {
      mainBar = {
        # Bar positioning
        layer = "top";
        position = "top";
        height = 50;
        #width = 44;
        spacing = 0;
        # Module placement
        modules-left = [ "custom/power" "custom/clockicon" "clock#2" "custom/notification" "niri/window" ];
        modules-center = [ "niri/workspaces" ];
        modules-right = [ "custom/media" "memory" "temperature" "battery" "wireplumber" "network" "bluetooth" "tray" ];

        # Module configuration
        # Left
        "custom/power" = {
          tooltip = false;
          format = "";
          on-click = "rofi -show power-menu -modi power-menu:rofi-power-menu";
          escape = true;
        };
        "custom/notification" = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            notification = "<span foreground='red'><sup></sup></span>";
            none = "";
            dnd-notification = "<span foreground='red'><sup></sup></span>";
            dnd-none = "";
            inhibited-notification = "<span foreground='red'><sup></sup></span>";
            inhibited-none = "";
            dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
            dnd-inhibited-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };
        "custom/clockicon" = {
          tooltip = false;
          format = "󰥔";
        };
        "clock#2" = {
          interval = 60;
          format = "<span size='9pt' weight='700'>{:L%R\n%x(%a)}</span>";
          tooltip-format = "<span size='9pt' font='Noto Sans Mono CJK JP'>{calendar}</span>";
          calendar = {
            mode = "month";
            mode-mon-col = 3;
            on-scroll = 1;
            format = {
              months = "<span color='#${config.stylix.base16Scheme.base05}'><b>{}</b></span>";
              days = "<span color='#${config.stylix.base16Scheme.base06}'><b>{}</b></span>";
              weekdays = "<span color='#${config.stylix.base16Scheme.base0F}'><b>{}</b></span>";
              today = "<span color='#${config.stylix.base16Scheme.base08}'><b>{}</b></span>";
            };
          };
        };
        "niri/window" = {
          format = "<span size='9pt' weight='700'>{}</span>";
          tooltip = false;
          separate-outputs = true;
        };
        # Center
        "niri/workspaces" = {
          format = "{icon}";
          format-icons = {
            "active" = "";
            "default" = "";
          };
        };
        # Right
        # Better MPRIS module
        "custom/media" = {
          format = "{icon}<span size='9pt' weight='700'>{}</span>";
          return-type = "json";
          format-icons = {
              "Playing" = " ";
              "Paused" = " ";
          };
          max-length = 70;
          exec = "playerctl -a metadata --format '{\"text\": \"{{artist}} - {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
          on-click = "playerctl play-pause";
          tooltip = false;
        };
        cava = {
          cava_config = "${config.home.homeDirectory}/.config/cava/config";
          format-icons = [ "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
          method = "pipewire";
          bars = 18;
          autosens = 1;
          source = "auto";
          bar_delimiter = 0;
          input_delay = 2;
          hide_on_silence = true;
        };
        bluetooth = {
          format = "";
	  format-disabled = "󰂲";
	  format-off = "󰂲";
	  format-connected = "";
	  tooltip-format = "{controller_alias}\t{controller_address}";
	  tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
	  tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
          on-click = "foot bluetui";
          on-click-right = "${bluetooth-toggle}";
        };
        cpu = {
          interval = 10;
          format = " {}%";
          max-length = 10;
        };
        temperature = {
          hwmon-path-abs =
          if (host == "miyazu") then
            "/sys/devices/pci0000:00/0000:00:18.3/hwmon"
          else
            "/sys/devices/platform/thinkpad_hwmon/hwmon";
          input-filename = "temp1_input";
          critical-threshold = 80;
          format = " {temperatureC}°C";
          tooltip = false;
        };
        battery = {
          interval = 60;
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-icons = [ "󰂎" "󰁼" "󰁾" "󰂀" "󰁹" ];
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰂌 {capacity}%";
          format-full = "󰂃 {capacity}%";
        };
        memory = {
          interval = 30;
          format = " {used:0.1f}G";
          tooltip-format = " {used:0.1f}G/{total:0.1f}G\n {swapUsed:0.1f}G/{swapTotal:0.1f}G";
        };
        wireplumber = {
          format = "{icon}";
          tooltip-format = "{icon} {node_name} {volume}%";
          format-muted = "󰝟";
          format-icons = [ "󰕿" "󰝞" "󰖀" "󰕾" ];
          on-click = "foot pulsemixer";
          on-scroll-up = "volumectl raise";
          on-scroll-down = "volumectl lower";
        };
        network = {
          format = "{icon}";
          format-icons = {
            ethernet = [ "" ];
            wifi = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
            disconnected = [ "󰌙" ];
          };
          tooltip-format = "{icon} {ifname} via {gwaddr}";
          tooltip-format-wifi = "{icon} {essid} ({signalStrength}%)";
          tooltip-format-ethernet = "{icon} {ifname}";
          tooltip-format-disconnected = "Disconnected";
        };
        tray = {
          icon-size = 16;
          spacing = 10;
        };
      };
    };
  };
}
