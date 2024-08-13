{ pkgs, lib, config, ... }: {
  options = {
    modules.mullvad.enable = lib.mkEnableOption "Enable Mullvad VPN";
  };

  config = lib.mkMerge [
    (lib.mkIf config.modules.mullvad.enable {
      # Mullvad manual setup (TODO automate)
      # mullvad account login NUM
      # mullvad connect
      # mullvad auto-connect set on
      # mullvad lan set allow
      # mullvad lockdown-mode set on
      services.mullvad-vpn.enable = true;

      # exclude steam game
      # mullvad-exculde %command%


      # TODO setup mappigs for all devices
      # Exclude yggdrasil from being blocked by mullvad
      networking.nftables = {
        enable = true;
        tables.excludeTraffic = {
          name = "excludeTraffic";
          family = "inet";
          content = ''
            define EXCLUDED_IPS = {
              200:902:9729:125:a8d3:eca2:d641:4a9b,
              202:8699:42dd:e354:50c5:5a7e:610b:1a18,
              202:bd8a:d171:53b9:deb0:7ac4:3257:80f0,
              206:f181:200:d9af:a582:9074:daba:f2ff
            }

            chain allowIncomming {
              type filter hook input priority -100; policy accept;
              ip6 saddr $EXCLUDED_IPS ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
            }

            chain excludeOutgoing {
              type route hook output priority -100; policy accept;
              ip6 daddr 200::/7 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
            }
          '';
        };
      };
    })
    (lib.mkIf (config.modules.mullvad.enable && config.modules.graphics.enable) {
      services.mullvad-vpn.package = pkgs.mullvad-vpn;
    })
  ];
}
