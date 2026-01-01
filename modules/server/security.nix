{ username, pkgs, ... }:

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

  services.fail2ban = {
    enable = true;
    maxretry = 5;
    ignoreIP = [
      "127.0.0.1/8"
      "192.168.1.0/24"  # Whitelist your LAN
    ];
  };
}
