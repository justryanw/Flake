{ config, ... }: {
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
  ];

  modules.disko.enable = true;

  disko.devices.disk.${config.networking.hostName}.device = "/dev/disk/by-id/nvme-WDS500G3X0C-00SJG0_2018GE480508";

  boot.loader.grub.gfxmodeEfi = "3440x1440";

  networking.hostName = "desktop";
  system.stateVersion = "24.11";
}
