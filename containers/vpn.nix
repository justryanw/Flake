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

  users.groups.media = { };
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
      systemd.services.transmission.serviceConfig = {
        RootDirectoryStartOnly = pkgs.lib.mkForce false;
        RootDirectory = pkgs.lib.mkForce "";
      };

      environment.systemPackages = (with pkgs; [
        iperf
      ]);

      services = {
        openvpn.servers = {
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

        yggdrasil = {
          enable = true;
          persistentKeys = true;
          group = "wheel";
          openMulticastPort = true;
          settings = {
            MulticastInterfaces = [
              {
                Regex = ".*";
                Beacon = true;
                Listen = true;
                Port = 9001;
                Priority = 0;
              }
            ];
          };
        };

        transmission = {
          enable = true;
          settings = {
            download-dir = "/home/Media/Torrents";
            incomplete-dir = "/home/Media/Torrents";
            rpc-bind-address = "::";
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

      networking = {
        hosts = {
          "200:f788:a3a9:56ae:d341:e3f7:c7f:c771" = [ "desktop" ];
          "202:8699:42dd:e354:50c5:5a7e:610b:1a18" = [ "laptop" ];
          "200:d13b:15e2:865:7c39:ad3f:fff6:cbbd" = [ "work" ];
          "200:5ec2:56e1:400a:a0e6:3266:d737:d89d" = [ "vm" ];
          "200:79ec:fa57:9588:9683:775e:d0ad:c6b9" = [ "kevin" ];
          "200:6e2:97ec:3a8a:eb8a:174e:e4dc:7ca1" = [ "pavilion" ];
          "200:14b1:5f2a:2f3f:515d:65ba:9c46:c45b" = [ "phone" ];
        };

        firewall = {
          allowedTCPPorts = [ 9001 ];

          extraCommands = ''
            iptables -A nixos-fw -s 192.168.0.0/24 -j nixos-fw-accept
            ip6tables -A nixos-fw -s desktop -j nixos-fw-accept
            ip6tables -A nixos-fw -s laptop -j nixos-fw-accept
            ip6tables -A nixos-fw -s work -j nixos-fw-accept
            ip6tables -A nixos-fw -s vm -j nixos-fw-accept
            ip6tables -A nixos-fw -s kevin -j nixos-fw-accept
            ip6tables -A nixos-fw -s pavilion -j nixos-fw-accept
            ip6tables -A nixos-fw -s phone -j nixos-fw-accept
          '';
          extraStopCommands = ''
            iptables -D nixos-fw -s 192.168.0.0/24 -j nixos-fw-accept || true
            ip6tables -D nixos-fw -s desktop -j nixos-fw-accept || true
            ip6tables -D nixos-fw -s laptop -j nixos-fw-accept || true
            ip6tables -D nixos-fw -s work -j nixos-fw-accept || true
            ip6tables -D nixos-fw -s vm -j nixos-fw-accept || true
            ip6tables -D nixos-fw -s kevin -j nixos-fw-accept || true
            ip6tables -D nixos-fw -s pavilion -j nixos-fw-accept || true
            ip6tables -D nixos-fw -s phone -j nixos-fw-accept || true
          '';
        };
      };

      system.stateVersion = "22.11";

      environment.etc."resolv.conf".text = "nameserver 8.8.8.8";

    };
  };

  services.jellyseerr.enable = true;
}
