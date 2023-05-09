{ ... }: {
  imports = [ ./shared.nix ];

  boot.loader.grub.device = "/dev/sda";
}