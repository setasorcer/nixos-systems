{ ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        pad = "24x24";
      };
      cursor = {
        style = "beam";
        blink = "yes";
      };
      mouse = {
        hide-when-typing = "yes";
      };
    };
  };
  home.sessionVariables.TERMINAL = "foot";
}
