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

    hyprpicker
  ];
  /*services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };*/
  services.displayManager.cosmic-greeter.enable = true;

  programs.kanshi = {
    enable = true;
    wallpaper = ./../../../papes/pape.jpg;
    wallpaperBlur = ./../../../papes/pape-blurred.jpg;
  };
  #programs.sunsetr.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts-cjk-sans
    nerd-fonts.inconsolata
    aileron
  ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd # OpenCL (fixes Davinci)
    ];
  };
}
