{ ... }: {
  networking = {
    networkmanager = {
      enable = true;
      unmanaged = [ "interface-name:ve-*" ];
    };

    nat = {
      enable = true;
      internalInterfaces = [ "ve-+" ];
      # DONT FORGET TO CHECK THIS
      externalInterface = "eno2";
    };
  };

  systemd.tmpfiles.rules = [
    "d /home/ryan/Torrents 777 ryan users"
  ];

  containers.vpn = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.0.110";
    localAddress = "192.168.0.111";
    enableTun = true;

    bindMounts = {
      "/home/Torrents" = {
        hostPath = "/home/ryan/Torrents";
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

      services.transmission = {
        enable = true;
        settings = {
          download-dir = "/home/Torrents";
          incomplete-dir = "/home/Torrents";
          rpc-bind-address = "192.168.0.111";
          rpc-whitelist = "192.168.0.110";
          umask = 0;
        };
        openRPCPort = true;
      };

      networking.firewall.enable = false;

      system.stateVersion = "22.11";

      environment.etc."resolv.conf".text = "nameserver 8.8.8.8";

    };
  };
}
