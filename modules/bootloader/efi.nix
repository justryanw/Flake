{ ... }: {
  imports = [ ./shared.nix ./minegrub.nix ];

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };

    grub = {
      efiSupport = true;
      device = "nodev";
    };
  };
}