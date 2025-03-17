{
  lib,
  rootConfig,
  ...
}: {
  config = lib.mkIf rootConfig.modules.gaming.enable {
    programs = {
      mangohud = {
        enable = true;
        enableSessionWide = false;

        settings = {
          fps_limit = 120;
          preset = -1;
          toggle_hud = "Shift_R+F12";
          toggle_fps_limit = "Shift_R+F11";
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
