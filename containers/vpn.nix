{ ... }: {

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
          config = ''
            remote-random
            remote uk1.vpn.ac 8000
            remote uk1.vpn.ac 50000
            dev tun
            tls-client
            persist-tun
            persist-key
            nobind
            pull
            redirect-gateway def1
            route-delay 3
            auth-user-pass
            verb 3
            explicit-exit-notify 2
            remote-cert-tls server
            key-direction 1
            cipher AES-256-CBC
            auth SHA512
            persist-remote-ip
            <ca>
            -----BEGIN CERTIFICATE-----
            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
            ojTHVLcWtOw59HQmLHot71o5fA==
            -----END CERTIFICATE-----
            </ca>
            <tls-auth>
            #
            # 2048 bit OpenVPN static key
            #
            -----BEGIN OpenVPN Static key V1-----
            d0cb0a06bee9619d7339af72c2c92a51
            2abf6168128d73bb5fc1ba4400dbebb6
            9e965cd28116f549de5986ebe0186792
            d2f60b4db9956acd450e9348c3076860
            10abf502cdfe7694b749b8ffc97e04b4
            888e52fd912ca6ab4ef69dfba89a951f
            61d3aebc305817f7ddf9fadf4f761e4c
            0176a72da02aa1f19cd1ce0aa34f3437
            55dbe18322c40a80072a12f1d10eb10c
            7de00676414beb13ed3b89903346328f
            6f8694f6bd4d4792ec1a09d58e65fe03
            8308afe9d8ff54f49f875e76e9252fa2
            913a8c1d0426dc0432748b878799ecc7
            3ff534e1bf0094a46c178cf871b3ddcf
            38f5219de8e87aec41c62db585564923
            2b2bbceafe21c81192e18cb210418769
            -----END OpenVPN Static key V1-----
            </tls-auth>
          '';
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
