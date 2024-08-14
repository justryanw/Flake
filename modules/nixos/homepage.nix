{ lib, config, ... }: {
  options.modules.homepage.enable = lib.mkEnableOption "Enable homepage";

  config = lib.mkIf config.modules.homepage.enable {
    services.homepage-dashboard = {
      enable = true;
      widgets = [
        {
          resources = {
            label = "System";
            cpu = true;
            memory = true;
            refresh = 500;
            cputemp = true;
            tempmin = 30;
            tempmax = 90;
          };
        }
        {
          resources = {
            label = "Root";
            disk = "/";
          };
        }
        {
          datetime = {
            format = {
              dateStyle = "long";
              timeStyle = "short";
              hour12 = true;
            };
          };
        }
      ];
      services = [
        {
          Group = [
            {
              Router = {
                description = "VM2601646";
                href = "http://192.168.0.1/";
              };
            }
          ];
        }
      ];
    };
  };
}
