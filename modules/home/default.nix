{ ... }:

{
  imports = [
    ./desktop
    ./programs
    ./shell
    ./xdg
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "floorp";
    TERMINAL = "foot";
  };
  home.file.".face".source = ./../../papes/avatar.jpg;
}
