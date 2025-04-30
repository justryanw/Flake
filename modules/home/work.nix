{
  pkgs,
  lib,
  config,
  rootConfig,
  ...
}: {
  options = {
    modules.work.enable = lib.mkEnableOption "Enable work software";
  };

  config = lib.mkIf (config.modules.work.enable && rootConfig.modules.gnome.enable) {
    home.packages = with pkgs; [
    ];
  };
}
