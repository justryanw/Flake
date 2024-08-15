{ config, ... }: {
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
