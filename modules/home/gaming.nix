{ lib, rootConfig, ... }: {
  config = lib.mkIf rootConfig.modules.gaming.enable {
    programs = {
      mangohud = {
        enable = true;
        enableSessionWide = true;
        settings = {
          fps_limit = 120;
          preset = 2;
        };
      };
    };
  };
}
