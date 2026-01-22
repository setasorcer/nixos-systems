{ pkgs, inputs, ... }:

{
  environment.variables.NIXOS_OZONE_WL = "1";
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
    gamescope
    xwayland-satellite-unstable

    hyprpicker
  ];
  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.inconsolata
    aileron
    # CJK Fonts
    ipaexfont
    baekmuk-ttf
    wqy_microhei
  ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd # OpenCL (fixes Davinci)
    ];
  };
}
