name:
{
  pkgs,
  lib,
  config,
  ...
}:
{
  config = lib.mkIf config.modules.users.${name}.enable {
    users.users.${name} = {
      hashedPasswordFile = config.sops.secrets.helen-password.path;

      packages = lib.mkIf config.modules.graphics.enable (
        with pkgs;
        [
          krita
          inkscape
          g4music
        ]
      );
    };
  };
}
