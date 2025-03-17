{
  lib,
  config,
  ...
}: {
  options = {
    modules.steamos.enable = lib.mkEnableOption "Enable Steam OS session";
  };

  config = lib.mkIf config.modules.steamos.enable {
    services.xserver.displayManager.gdm.enable = false;

    jovian.steam = {
      enable = true;
      autoStart = true;
      desktopSession = "gnome";
      user = "ryan";
    };
  };
}
