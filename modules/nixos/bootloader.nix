{ lib, config, ... }: {
  options = {
    modules.grub.enable = lib.mkEnableOption "Enable grub";
  };

  config = lib.mkIf config.modules.grub.enable {
    boot.loader = {
      efi.canTouchEfiVariables = true;

      grub = {
        enable = true;
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
