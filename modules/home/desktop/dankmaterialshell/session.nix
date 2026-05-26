{ ... }:

{
  programs.dank-material-shell.session = {
    nightModeEnabled = true;
    nightModeAutoEnabled = true;
    nightModeAutoMode = "location";
    nightModeUseIPLocation = true;
    wallpaperTransition = "random";
    includedTransitions = [
      "fade"
      "wipe"
      "disc"
      "stripes"
      "iris bloom"
      "pixelate"
      "portal"
    ];
  };
}
