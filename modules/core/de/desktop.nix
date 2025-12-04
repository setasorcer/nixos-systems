{ pkgs, inputs, ... }:

{
  environment.variables.NIXOS_OZONE_WL = "1";
  nixpkgs.overlays = [ inputs.niri.overlays.niri ];
  programs.niri = {
    enable = true;
    package = pkgs.niri-stable;
  };
  environment.systemPackages = with pkgs; [
    wl-clipboard
    wayland-utils
    gamescope
    xwayland-satellite-unstable

    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    hyprpicker
  ];
  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts-cjk-sans
    nerd-fonts.inconsolata
  ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd # OpenCL (fixes Davinci)
    ];
  };
}
