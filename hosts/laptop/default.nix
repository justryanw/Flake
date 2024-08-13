{ ... }: {
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
  ];

  boot.loader.grub = {
    gfxmodeEfi = "1920x1080";
    device = "nodev";
  };

  networking.hostName = "laptop";
  system.stateVersion = "22.11";
}
