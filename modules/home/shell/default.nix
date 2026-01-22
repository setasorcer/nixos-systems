{ config, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
    shellAbbrs = {
      hydrus = "hydrus-client -d ${config.home.homeDirectory}/pix/hydrus";
      fetch = "fastfetch";
    };
  };
}
