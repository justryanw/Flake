{config, ...}: {
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
  ];

  modules = {
    nixbuild.enable = true;
  };

  boot.loader.grub.gfxmodeEfi = "1920x1080";

  disko.devices.disk.${config.networking.hostName}.device = "/dev/disk/by-id/ata-PNY_CS900_120GB_SSD_PNY101822413501040C1";

  networking.hostName = "jack";
  system.stateVersion = "25.05";
}
