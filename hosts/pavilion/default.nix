{ ... }: {
  imports = [ ./hardware-configuration.nix ];

  boot.loader.grub.gfxmodeEfi = "1920x1080";

  networking.hostName = "Pavilion";
}
