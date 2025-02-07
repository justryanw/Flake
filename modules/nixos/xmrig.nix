{
  lib,
  config,
  ...
}:
let
  cfg = config.modules.xmrig;
in
{
  options.modules.xmrig = {
    enable = lib.mkEnableOption "Enable xmrig";
    threads = lib.mkOption {
      type = lib.types.nullOr lib.types.int;
      default = null;
      description = "Limit's the number of threads if set";
    };
    name = lib.mkOption {
      type = lib.types.nullOr lib.types.string;
      default = null;
      description = "Name of the worker";
    };
  };

  config = lib.mkIf cfg.enable {
    services.xmrig = {
      enable = true;
      settings = {
        autosave = true;
        cpu = {
          enabled = true;
          rx = lib.mkIf (cfg.threads != null) {
            threads = cfg.threads;
          };
        };
        opencl = false;
        cuda = false;
        pools = [
          {
            url = "pool.hashvault.pro:443";
            user = "84jLA5hxrGkNrj7kLpZt519MCWwPyMj8oBt9ikTAqoZvG8Qcd3PFGmkZNDPDT9jk7FZ39VzNMgqzFXLHEKvs9pcF6L8DaTm";
            pass = lib.mkIf (cfg.name != null) cfg.name;
            keepalive = true;
            tls = true;
          }
        ];
      };
    };
  };
}
