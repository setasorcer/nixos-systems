{ ... }:

{
  programs.dank-material-shell = {
    plugins = {
      calculator.enable = true;
      mediaPlayer.enable = true;
      screenRecorder.enable = true;
    };
  };
}
