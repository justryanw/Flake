{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    modules.sql.enable = lib.mkEnableOption "Enable SQL";
  };

  config = lib.mkIf config.modules.sql.enable {
    services.mysql = {
      enable = true;
      package = pkgs.mariadb;
    };
  };
}
