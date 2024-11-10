{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    modules.glances.enable = lib.mkEnableOption "Enable glances";
  };

  config = lib.mkIf config.modules.glances.enable {
    systemd.services.glances = {
      description = "glances";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.glances}/bin/glances -B :: -w";
        Restart = "always";
        RemainAfterExit = "no";
      };
    };
  };
}
