name:
{ lib, config, ... }@inputs:
{
  config = lib.mkIf config.modules.users.${name}.enable {
    home-manager.users.${name} =
      { ... }:
      {
        modules.work.enable = false;
      };
  };
}
