{ pkgs, ... }: {
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
  ];

  modules = {
    gaming.enable = false;
    gnome.enable = false;
    users.helen.enable = false;
    amd.enable = false;
  };

  networking = {
    hostName = "server";

    wireless.iwd = {
      enable = true;
      settings = {
        IPv6.Enabled = true;
        Settings.AutoConnect = true;
      };
    };

    # TODO setup mappigs for all devices

    # Exclude yggdrasil from being blocked by mullvad
    firewall = {
      extraCommands = "";
      extraStopCommands = "";
      extraInputRules = ''
        ip6 saddr 202:9cf8:d9b1:83e5:f832:c74e:8fb7:e6c9 accept
        ip6 saddr 202:8699:42dd:e354:50c5:5a7e:610b:1a18 accept
      '';
    };
    nftables = {
      enable = true;
      tables.excludeTraffic = {
        name = "excludeTraffic";
        family = "inet";
        content = ''
          define EXCLUDED_IPS = {
            202:9cf8:d9b1:83e5:f832:c74e:8fb7:e6c9,
            202:8699:42dd:e354:50c5:5a7e:610b:1a18
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
  };

  # Mullvad manual setup (TODO automate)
  # mullvad account login NUM
  # mullvad auto-connect set on
  # mullvad lockdown-mode set on
  # mullvad lan set allow
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad;
  };

  system.stateVersion = "24.11";
}
