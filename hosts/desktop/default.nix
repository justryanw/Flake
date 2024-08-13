{ config, ... }: {
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
  ];

  disko.devices.disk.${config.networking.hostName}.device = "/dev/nvme1n1";

  boot.loader.grub.gfxmodeEfi = "3440x1440";

  networking.hostName = "desktop";
  system.stateVersion = "23.05";
}
