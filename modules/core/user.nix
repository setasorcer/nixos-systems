{ username, host, pkgs, inputs, ... }:

{
  imports = [ inputs.home-manager.nixosModules.default ];
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [ "networkmanager" "wheel" "syncthing" ];
    shell = pkgs.fish;
  };

  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = { inherit inputs host; };
    useGlobalPkgs = true;
    users = {
      "${username}" = {
        imports = [ ./../home ];
        # Place skeleton hm config here
        home.username = "${username}";
        home.homeDirectory = "/home/${username}";
        home.stateVersion = "24.11";
        programs.home-manager.enable = true;
      };
    };
  };
}
