{ inputs, ... }:

{
  imports = [ inputs.copyparty.nixosModules.default ];
  nixpkgs.overlays = [ inputs.copyparty.overlays.default ];
  services.copyparty = {
    enable = true;
    settings = {
      i = "0.0.0.0";
      p = 3923;
    };
    volumes = {
      # create a volume at "/" (the webroot), which will
      "/" = {
        # share the contents of "/srv/copyparty"
        path = "/mnt/zichi/share";
        # see `copyparty --help-accounts` for available options
        access = {
          rwmd = "*";
        };
        # see `copyparty --help-flags` for available options
        flags = {
          # "fk" enables filekeys (necessary for upget permission) (4 chars long)
          fk = 4;
          # scan for new files every 60sec
          scan = 60;
          # volflag "e2d" enables the uploads database
          e2d = true;
          # "d2t" disables multimedia parsers (in case the uploads are malicious)
          d2t = true;
          # skips hashing file contents if path matches *.iso
          nohash = "\.iso$";
        };
      };
    };
  };
  networking.firewall.allowedTCPPorts = [ 3923 ];
}
