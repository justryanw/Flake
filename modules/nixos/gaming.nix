{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    modules.gaming.enable = lib.mkEnableOption "Enable Steam and gamemode";
  };

  config = lib.mkIf config.modules.gaming.enable {
    environment.systemPackages = with pkgs; [
      modrinth-app
    ];

    programs = {
      steam = {
        enable = true;
        gamescopeSession.enable = true;
        # package = pkgs.steam.override {
        #   extraEnv = {
        #     MANGOHUD = true;
        #   };
        # };
      };

      gamemode.enable = true;
    };
  };
}
