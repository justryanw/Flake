{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    modules.hyprland.enable = lib.mkEnableOption "Enable Hyprland desktop and graphics support";
  };

  config = lib.mkIf config.modules.hyprland.enable {
    modules.graphics.enable = true;

    programs.hyprland = {
      enable = true;
      withUWSM = true;
    };

    environment.systemPackages = [pkgs.kitty];
  };
}
