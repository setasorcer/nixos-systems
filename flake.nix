{
  description = "NixOS for Kyoko";

  # Cachix
  nixConfig = {
    extra-substituters = [ "https://ezkea.cachix.org" ];
    extra-trusted-public-keys = [ "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI=" ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: 
  let
    username = "kyoko";
  in
  {
    nixosConfigurations = {
      miyazu = nixpkgs.lib.nixosSystem {
        modules = [ ./hosts/miyazu ];
        specialArgs = {
          host = "miyazu";
          inherit self inputs username;
        };
      };
      itsuku = nixpkgs.lib.nixosSystem {
        modules = [ ./hosts/itsuku ];
        specialArgs = {
          host = "itsuku";
          inherit self inputs username;
        };
      };
      teppei = nixpkgs.lib.nixosSystem {
        modules = [ ./hosts/teppei ];
        specialArgs = {
          host = "teppei";
          inherit self inputs username;
        };
      };
    };
  };
}
