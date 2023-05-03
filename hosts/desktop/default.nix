{ ... }: {
  imports = [ ./hardware-configuration.nix ];

  boot.loader.grub.gfxmodeEfi = "3440x1440";

  networking.hostName = "Desktop";
}
