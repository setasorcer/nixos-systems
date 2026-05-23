{ username, pkgs, inputs, ... }:

{
  environment.variables.NIXOS_OZONE_WL = "1";
  # Set icon theme for noctalia
  environment.variables.QS_ICON_THEME = "Adwaita";
  nixpkgs.overlays = [ inputs.niri-pkgs.overlays.niri ];
  programs.niri = let
    niriPkgs = inputs.niri-pkgs.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    enable = true;
    package = niriPkgs.niri-unstable;
  };
  # Greeter - DankGreeter
  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/${username}";
    package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
  services.accounts-daemon.enable = true; # Stores information like profile picture for DMS
  programs.dsearch.enable = true;

  environment.systemPackages = with pkgs; [
    wl-clipboard
    wayland-utils
  ];
}
