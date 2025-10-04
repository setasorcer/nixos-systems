{ pkgs, username, ... }:

{
  # Doas (replace sudo)
  security.sudo.enable = false;
  security.doas = {
    enable = true;
    extraRules = [{
      users = ["${username}"];
      keepEnv = true;
      persist = true;
    }];
  };
  environment.systemPackages = [ pkgs.doas-sudo-shim ];
  # Enable HM hyprlock to perform authentication
  security.pam.services.hyprlock = {};
}
