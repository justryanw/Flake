{ config, ... }:
{
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
  ];

  modules = {
    disko.enable = true;
    amd.enable = false;
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/8d914232-b7b0-4a4d-b31c-b5401c2e9f1f";
    fsType = "ext4";
  };

  disko.devices.disk.${config.networking.hostName}.device =
    "/dev/disk/by-id/nvme-eui.e8238fa6bf530001001b444a44d43292";

  boot.loader.grub.gfxmodeEfi = "1920x1080";

  networking.hostName = "pavilion";
  system.stateVersion = "24.11";

  services.xmrig = {
    enable = true;
    settings = {
      autosave = true;
      cpu = {
        enabled = true;
        rx = {
          threads = 6;
        };
      };
      opencl = false;
      cuda = false;
      pools = [
        {
          url = "pool.hashvault.pro:443";
          user = "84jLA5hxrGkNrj7kLpZt519MCWwPyMj8oBt9ikTAqoZvG8Qcd3PFGmkZNDPDT9jk7FZ39VzNMgqzFXLHEKvs9pcF6L8DaTm";
          pass = "server";
          keepalive = true;
          tls = true;
        }
      ];
    };
  };
}
