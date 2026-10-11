{ config, ... }:

{
  imports = [
    ./binds.nix
    ./colors.nix
    ./general.nix
    ./rules.nix
  ];

  systemd.user.tmpfiles.rules = [
    "f %h/.config/umbriel/config.toml 0644 - - - [include]\\nfiles = [ \"binds.toml\", \"colors.toml\", \"general.toml\", \"rules.toml\" ]"
  ];
}
