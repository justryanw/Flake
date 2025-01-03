{ lib, rootConfig, ... }:
{
  config = lib.mkIf rootConfig.modules.gaming.enable {
    programs = {
      mangohud = {
        enable = true;
        enableSessionWide = false;

        settings = {
          fps_limit = 120;
          preset = 0;
        };

        settingsPerApplication = {
          zed-editor = {
            no_display = true;
          };
        };
      };
    };
  };
}
