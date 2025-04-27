{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
  options = {
    modules.gaming.enable = lib.mkEnableOption "Enable Steam and gamemode";
  };

  config = lib.mkIf config.modules.gaming.enable {
    nixpkgs.overlays = [inputs.polymc.overlay];

    environment.systemPackages = [pkgs.polymc];

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
