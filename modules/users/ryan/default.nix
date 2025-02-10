name:
{
  pkgs,
  lib,
  config,
  ...
}:
let
  grayjay-app = pkgs.callPackage ../../../pkgs/grayjay.nix { };
  spine = pkgs.callPackage ../../../pkgs/spine.nix { };
in
{
  imports = [ (import ./home.nix name) ];

  config = lib.mkIf config.modules.users.${name}.enable {
    users.users.${name} = {
      extraGroups = [ "wheel" ];
      initialHashedPassword = lib.mkDefault "$y$j9T$/0D7TzdJ47wVaY77j8gnJ.$RKHvm/DQTTD8xCdx1ZRhhj9fMuiP5kocHXRmwBBPPR1";

      packages = lib.mkIf config.modules.graphics.enable [
        grayjay-app
        spine
      ];
    };
  };
}
