{ pkgs, inputs, ... }:

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
  # Greeter - COSMIC
  services.displayManager.cosmic-greeter.enable = true;

  environment.systemPackages = with pkgs; [
    wl-clipboard
    wayland-utils
  ];
}
