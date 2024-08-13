{ lib, config, ... }: {
  options.modules.homepage.enable = lib.mkEnableOption "Enable homepage";

  config = lib.mkIf config.modules.homepage.enable {
    services.homepage-dashboard = {
      enable = true;
    };
  };
}
