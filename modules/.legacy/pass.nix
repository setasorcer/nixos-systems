{ config, pkgs, ... }:

{
  home.packages = [ pkgs.tessen ];
  # Tessen config
  home.file.".config/tessen/config".text = ''
    dmenu_backend="rofi"
    action="copy"
    notify="false"
  '';
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
    package = pkgs.pass-nodmenu.withExtensions (exts: [ exts.pass-import ]);
    settings = {
      PASSWORD_STORE_DIR = "${config.xdg.dataHome}/password-store";
    };
  };
}
