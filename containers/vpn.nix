{ interface, ... }: {
  networking = {
    networkmanager = {
      enable = true;
      unmanaged = [ "interface-name:ve-*" ];
    };

    nat = {
      enable = true;
      internalInterfaces = [ "ve-+" ];
      # DONT FORGET TO CHECK THIS
      externalInterface = interface;
    };
  };

  users.groups.media = {};
  users.users.ryan.extraGroups = [ "media" ];

  systemd.tmpfiles.rules = [
    "d /home/Media 0777 - media - -"
    "d /home/Media/Torrents 777 ryan users"
    "d /home/Media/Torrents/Prowlarr 777 ryan users"
    "d /home/Media/Torrents/Radarr 777 ryan users"
    "d /home/Media/Torrents/Sonarr 777 ryan users"
    "d /home/Media/Torrents/Lidarr 777 ryan users"
    "d /home/Media/Movies 777 ryan media"
    "d /home/Media/Series 777 ryan media"
    "d /home/Media/Anime 777 ryan media"
    "d /home/Media/Music 777 ryan media"
  ];

  containers.vpn = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.0.110";
    localAddress = "192.168.0.111";
    enableTun = true;

    bindMounts = {
      "/home/Media" = {
        hostPath = "/home/Media";
        isReadOnly = false;
      };
    };

    config = { config, pkgs, ... }: {

      services.openvpn.servers = {
        main = {
          config = "config /home/config.ovpn";
          /*
            home
              config.ovpn
              credentails.txt

            -- config.ovpn --
            ...
            auth-user-pass /home/credentails.txt
            ...

            -- credentials.txt --
            username
            password
          */
        };
      };

      systemd.services.transmission.serviceConfig = {
        RootDirectoryStartOnly = pkgs.lib.mkForce false;
        RootDirectory = pkgs.lib.mkForce "";
      };

      services = {
        transmission = {
          enable = true;
          settings = {
            download-dir = "/home/Media/Torrents";
            incomplete-dir = "/home/Media/Torrents";
            rpc-bind-address = "0.0.0.0";
            rpc-whitelist-enabled = false;
            umask = 0;
          };
          openRPCPort = true;
        };

        prowlarr.enable = true;
        radarr.enable = true;
        sonarr.enable = true;
        lidarr.enable = true;
      };

      networking.firewall.enable = false;

      system.stateVersion = "22.11";

      environment.etc."resolv.conf".text = "nameserver 8.8.8.8";

    };
  };

  services.jellyseerr.enable = true;
}
