{ ... }: {
  imports = [ ./hardware-configuration.nix ];

  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "NixVM";
}
