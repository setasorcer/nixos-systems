{ pkgs, ... }:

{
  # Fcitx5
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = with pkgs; [ fcitx5-mozc fcitx5-gtk ];
    };
  };

  # Keyd
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" "-cb10:1556" ];
        settings.main = {
          capslock = "overload(control,esc)"; # Caps lock -> LCTL on hold, ESC on tap
          esc = "capslock"; # ESC -> Caps lock
          pause = "esc"; # I believe this setting comes from a T430 setup
          sysrq = "overload(meta,sysrq)"; # Print screen -> GUI on hold, Print screen on tap
          # Designed with a ThinkPad T480 in mind
        };
        settings.global = {
          overload_tap_timeout = 175; # Faster timeout (default 200)
        };
      };
      # No configuration for my Iris CE (for now)
      "iris-ce" = {
        ids = [ "cb10:1556" ];
      };
    };
  };

}
