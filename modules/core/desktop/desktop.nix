{ pkgs, inputs, ... }:

{
  environment.variables.NIXOS_OZONE_WL = "1";
  # Set icon theme for noctalia
  environment.variables.QS_ICON_THEME = "Adwaita";
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  programs.niri = {
    enable = true;
    package = pkgs.niri-stable;
  };
  # Greeter - COSMIC
  services.displayManager.cosmic-greeter.enable = true;

  environment.systemPackages = with pkgs; [
    wl-clipboard
    wayland-utils
    xwayland-satellite-unstable
  ];
}
