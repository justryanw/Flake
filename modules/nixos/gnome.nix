{ lib, config, ... }: {
  options = {
    modules.gnome.enable = lib.mkEnableOption "Enable Gnome desktop and graphics support";
  };

  config = lib.mkIf config.modules.gnome.enable {
    modules.graphics.enable = true;

    services.xserver = {
      desktopManager.gnome.enable = true;
      displayManager.gdm = {
        enable = true;
        autoSuspend = false;
      };
    };
  };
}
