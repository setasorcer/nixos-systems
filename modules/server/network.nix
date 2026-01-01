{ host, ... }:

{
  networking.hostName = "${host}";
  networking.hostId = "725e1640";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  
  networking.networkmanager.enable = true;
}
