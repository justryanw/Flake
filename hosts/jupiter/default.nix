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

  disko.devices.disk.${config.networking.hostName}.device = "/dev/disk/by-id/nvme-eui.6479a759203003dd";

  networking.hostName = "jupiter";
  system.stateVersion = "25.05";
}
