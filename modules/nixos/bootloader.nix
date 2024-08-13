{ lib, config, ... }: {
  options = {
    modules.grub.enable = lib.mkEnableOption "Enable grub";
  };

  config = lib.mkIf config.modules.grub.enable {
    boot.loader.grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      # device = "nodev";
      extraEntries = ''
        menuentry 'Reboot into BIOS' $menuentry_id_option 'uefi-firmware' {
          fwsetup
        }
        menuentry 'Shutdown' {
          halt
        }
      '';
    };
  };
}
