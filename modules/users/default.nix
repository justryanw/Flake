{ lib, ... }:
let
  users = [ "ryan" "helen" "nixos" ];
  defaultUsers = [ "ryan" "helen" ];
  common = builtins.map (name: (import ./common name)) users;
  custom = builtins.map (name: (import ./${name} name)) users;
in
{
  imports = common ++ custom;

  config = {
    modules.users = builtins.listToAttrs
      (map
        (name: {
          inherit name;
          value = {
            enable = lib.mkDefault true;
            defaultConfig.enable = lib.mkDefault true;
          };
        })
        defaultUsers);
  };
}
