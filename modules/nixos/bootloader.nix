{ pkgs, lib, config, ... }: {
  options = {
    bootloader.grub.enable = lib.mkEnableOption "Enable grub";
  };

  config = lib.mkIf config.bootloader.grub.enable {
    boot.loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };

      systemd-boot.enable = false;

      grub = {
        enable = true;
        useOSProber = true;
        efiSupport = true;
        device = "nodev";
        extraEntries = ''
          menuentry 'System setup' $menuentry_id_option 'uefi-firmware' {
            fwsetup
          }
        '';
      };
    };
  };
}
