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
          capslock = "overload(control,esc)";
          esc = "capslock";
          pause = "esc";
          sysrq = "overload(meta,sysrq)";
        };
        settings.global = {
          overload_tap_timeout = 175;
        };
      };
      lily58 = {
        ids = [ "cb10:1556" ];
        settings.meta = {
          m = "M-h";
          n = "M-j";
          e = "M-k";
          i = "M-l";
          h = "M-m";
          j = "M-n";
          k = "M-e";
          l = "M-i";
        };
      };
    };
  };

}
