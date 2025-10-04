{ config, pkgs, ... }:

{
  programs.gpg = {
    enable = true;
    homedir = "${config.xdg.dataHome}/gnupg";
  };
  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-gnome3;
  };
  services.polkit-gnome.enable = true;
  programs.password-store = {
    enable = true;
    package = pkgs.pass-nodmenu;
    settings = {
      PASSWORD_STORE_DIR = "${config.xdg.dataHome}/password-store";
    };
  };
}
