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

    # extra(stop)Commands arent compatible with nftables
    # this setup is working but now blocked by nixos firewall instead of mullvad becase extracommands disabled
    # possible use "firewall.extraInputRules" instead of extraCommand to allow own ips

    # Exclude yggdrasil from being blocked by mullvad
    firewall = {
      extraCommands = "";
      extraStopCommands = "";
      extraInputRules = "ip6 daddr 200::/7 accept";
    };
    nftables = {
      enable = true;
      tables.excludeTraffic = {
        name = "excludeTraffic";
        family = "inet";
        content = ''
          chain allowIncomming {
            type filter hook input priority -100; policy accept;
            ip6 daddr 200::/7 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
          }

          chain excludeOutgoing {
            type route hook output priority -100; policy accept;
            ip6 daddr 202:9cf8:d9b1:83e5:f832:c74e:8fb7:e6c9 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
          }
        '';
      };
    };
  };

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad;
  };

  system.stateVersion = "24.11";
}
