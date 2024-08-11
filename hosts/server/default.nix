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

    # Exclude yggdrasil from being blocked by mullvad
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
            ip6 daddr 200::/7 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
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
