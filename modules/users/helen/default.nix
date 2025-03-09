name: {
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.modules.users.${name}.enable {
    users.users.${name} = {
      initialHashedPassword = "$y$j9T$VcFtf.LY2BA.ICsKVYa.X.$lEGovq2oX/EwnV5Q/8Rj2vehlUi3fWaP3UIayolWSU8";

      packages = lib.mkIf config.modules.graphics.enable (
        with pkgs; [
          krita
          inkscape
          g4music
        ]
      );
    };
  };
}
