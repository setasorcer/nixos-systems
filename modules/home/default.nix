{ ... }:

{
  imports = [
    ./desktop
    ./programs
    ./shell
    ./xdg
  ];

  home.file.".face".source = ./../../avatar.jpg;
}
