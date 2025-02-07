name:
{
  pkgs,
  lib,
  config,
  ...
}:
let
  grayjay-app = pkgs.callPackage ../../../pkgs/grayjay.nix { };
  spine = pkgs.callPackage ../../../pkgs/spine.nix {
    # licenseKey = "";
  };
in
{
  imports = [ (import ./home.nix name) ];

  config = lib.mkIf config.modules.users.${name}.enable {
    sops.secrets.ryan-password.neededForUsers = true;

    users.users.${name} = {
      extraGroups = [ "wheel" ];
      hashedPasswordFile = config.sops.secrets.ryan-password.path;

      packages = lib.mkIf config.modules.graphics.enable [
        grayjay-app
        spine
      ];
    };
  };
}
