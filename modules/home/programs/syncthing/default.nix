{ config, ... }:

{
  services.syncthing = {
    enable = false;
    settings = {
        devices = {
          "droid" = { id = "T3XFMZZ-BVLSDLN-ZHH3WRO-WL35HXD-5WCXVWV-6OSJMNQ-LNCL5MG-GIWCFA3"; };
        };
        folders = {
          "${config.home.homeDirectory}/pix/.${config.home.username}" = {
            id = "kcz3h-t062i";
            label = "${config.home.username}";
            devices = [ "droid" ];
          };
        };
      };
    };
}
