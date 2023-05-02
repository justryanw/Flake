{ pkgs, config, lib, ... }: {

  networking = {
    networkmanager = {
      enable = true;
      unmanaged = [ "interface-name:ve-*" ];
    };

    nat = {
      enable = true;
      internalInterfaces = [ "ve-+" ];
      externalInterface = "wlp2s0";
    };
  };

  containers.vpn = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.0.110";
    localAddress = "192.168.0.111";
    enableTun = true;

    config = { config, pkgs, ... }: {

      services.openvpn.servers = {
        main = {
          config = '' config /root/uk_london-aes256-udp.ovpn '';
        };
      };

      systemd.tmpfiles.rules = [
        "d /home/Torrents 775 transmission transmission"
      ];

      services.transmission = {
        enable = true;
        settings = {
          download-dir = "/home/Torrents";
          incomplete-dir = "/home/Torrents";
          rpc-bind-address = "192.168.0.111";
          rpc-whitelist = "192.168.0.110";
        };
        openRPCPort = true;
      };

      networking.firewall.enable = false;

      system.stateVersion = "22.11";

      environment.etc."resolv.conf".text = "nameserver 8.8.8.8";

    };
  };
}
