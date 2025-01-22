{ config, ... }:
{
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
  ];

  modules = {
    disko.enable = true;
    steamos.enable = true;
    users.helen.enable = false;
  };

  disko.devices.disk.${config.networking.hostName}.device =
    "/dev/disk/by-id/nvme-eui.6479a759203003dd";

  networking.hostName = "jupiter";
  system.stateVersion = "25.05";

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
