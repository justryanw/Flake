{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    modules.gnome.enable = lib.mkEnableOption "Enable Gnome desktop and graphics support";
  };

  config = lib.mkIf config.modules.gnome.enable {
    modules.graphics.enable = true;

    services.xserver = {
      desktopManager = {
        gnome.enable = true;
        xterm.enable = false;
      };
      displayManager.gdm = {
        enable = lib.mkDefault true;
        autoSuspend = false;
      };
      excludePackages = [pkgs.xterm];
    };

    environment.gnome.excludePackages = builtins.attrValues {
      inherit
        (pkgs)
        epiphany
        geary
        gnome-tour
        totem
        gnome-music
        yelp
        ;
    };
  };
}
