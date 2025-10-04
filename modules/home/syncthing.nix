{ config, ... }:

{
  # Syncthing
  services.syncthing = {
    enable = true;
    settings = {
        devices = {
          "droid" = { id = "T3XFMZZ-BVLSDLN-ZHH3WRO-WL35HXD-5WCXVWV-6OSJMNQ-LNCL5MG-GIWCFA3"; };
        };
        folders = {
          "${config.home.homeDirectory}/dox/send" = {
            id = "d8mzi-18znf";
            label = "shared";
            devices = [ "droid" ];
          };
          "${config.home.homeDirectory}/pix/.${config.home.username}" = {
            id = "kcz3h-t062i";
            label = "${config.home.username}";
            devices = [ "droid" ];
          };
        };
      };
    };
}
