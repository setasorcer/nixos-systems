{ username, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [ "networkmanager" "wheel" "immich" "kyoka" "deluge" "slskd" ];
  };
  programs.bash.shellInit = ''umask 0002'';

  users.groups.kyoka = {};
}
