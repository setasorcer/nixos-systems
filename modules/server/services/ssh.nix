{ username, ... }:

{
  services = {
    openssh = {
      enable = true;
      ports = [ 1075 ];
      settings = {
        PermitRootLogin = "no";
	AllowUsers = [ "${username}" ];
      };
    };
    fail2ban.enable = true;
    endlessh = {
      enable = true;
      port = 22;
      openFirewall = true;
    };
  };
}
