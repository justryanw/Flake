{ config, pkgs, ... }: {
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
  ];

  disko.devices.disk.${config.networking.hostName}.device = "/dev/disk/by-id/nvme-WDC_WDS250G2B0C-00PXH0_21140K457811";

  modules = {
    gaming.enable = false;
    gnome.enable = false;
    users.helen.enable = false;
    amd.enable = false;
    disko.enable = true;
    homepage.enable = true;
  };

  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/40d5fc81-5852-42d1-8bc2-befba6d438b4";
    fsType = "bcachefs";
  };

  services = {
    # Enable IPv6 and remote access from cli
    # https://forum.jellyfin.org/printthread.php?tid=7357
    jellyfin = {
      enable = true;
      user = "ryan";
      group = "data";
      dataDir = "/data/jellyfin";
    };

    transmission = {
      enable = true;
      user = "ryan";
      group = "data";
      settings = {
        download-dir = "/data/media/torrents";
        rpc-bind-address = "::";
        rpc-whitelist-enabled = false;
      };
      webHome = pkgs.flood-for-transmission;
    };
  };

  users = {
    groups.data = { };
    users.ryan.extraGroups = [ "data" ];
  };

  systemd.tmpfiles.rules = [
    "d /data 775 root data"
    "d /data/media/torrents 775 ryan data"
  ];

  networking = {
    hostName = "server";

    wireless.iwd = {
      enable = true;
      settings = {
        IPv6.Enabled = true;
        Settings.AutoConnect = true;
      };
    };
  };

  system.stateVersion = "24.11";
}
