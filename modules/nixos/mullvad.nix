{ pkgs, lib, config, ... }: {
  options = {
    modules.mullvad.enable = lib.mkEnableOption "Enable Mullvad VPN";
  };

  config = lib.mkMerge [
    (lib.mkIf config.modules.mullvad.enable {
      # Mullvad manual setup (TODO automate)
      # mullvad account login NUM
      # mullvad auto-connect set on
      # mullvad lockdown-mode set on
      # mullvad lan set allow
      services.mullvad-vpn.enable = true;

      # TODO setup mappigs for all devices
      # Exclude yggdrasil from being blocked by mullvad
      networking.nftables = {
        enable = true;
        tables.excludeTraffic = {
          name = "excludeTraffic";
          family = "inet";
          content = ''
            define EXCLUDED_IPS = {
              202:9cf8:d9b1:83e5:f832:c74e:8fb7:e6c9,
              202:8699:42dd:e354:50c5:5a7e:610b:1a18
              200:2cf:8be6:89d7:60a7:b022:7cf0:97a9
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
    (lib.mkIf (config.modules.mullvad.enable && !config.modules.graphics.enable) {
      services.mullvad-vpn.package = pkgs.mullvad;
    })
  ];
}
