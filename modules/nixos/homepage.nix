{ lib, config, ... }: {
  options.modules.homepage.enable = lib.mkEnableOption "Enable homepage";

  config = lib.mkIf config.modules.homepage.enable {
    services.homepage-dashboard = {
      enable = true;
      widgets = [
        {
          resources = {
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
          glances = {
            url = "http://[::1]:61208";
            cpu = false;
            mem = false;
            label = "Data";
            disk = "/data";
            version = 4;
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
          Media = [
            {
              Jellyfin = {
                icon = "jellyfin.png";
                href = "http://[202:bd8a:d171:53b9:deb0:7ac4:3257:80f0]:8096";
              };
            }
            {
              Jellyseerr = {
                icon = "jellyseerr.png";
                href = "http://[202:bd8a:d171:53b9:deb0:7ac4:3257:80f0]:5055";
              };
            }
            {
              Transmission = {
                icon = "transmission.png";
                href = "http://[202:bd8a:d171:53b9:deb0:7ac4:3257:80f0]:9091";
              };
            }
            {
              Radarr = {
                icon = "radarr.png";
                href = "http://[202:bd8a:d171:53b9:deb0:7ac4:3257:80f0]:7878";
              };
            }
            {
              Sonarr = {
                icon = "sonarr.png";
                href = "http://[202:bd8a:d171:53b9:deb0:7ac4:3257:80f0]:8989";
              };
            }
            {
              Prowlarr = {
                icon = "prowlarr.png";
                href = "http://[202:bd8a:d171:53b9:deb0:7ac4:3257:80f0]:9696";
              };
            }
          ];
        }
        {
          Monitoring = [
            {
              Glances = {
                href = "http://[202:bd8a:d171:53b9:deb0:7ac4:3257:80f0]:61208";
              };
            }
          ];
        }
        {
          Other = [
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
