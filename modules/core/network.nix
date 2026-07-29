{ host, ... }:

{
  networking.hostName = "${host}";
  networking.networkmanager.enable = true;

  networking.nameservers = [ "127.0.0.1" ];
  services.dnsmasq = {
    enable = true;
    settings = {
      server = [ "192.168.1.229" "192.168.1.1" ];
      strict-order = true;
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
