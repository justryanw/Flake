{ pkgs, ... }: {
  boot = {
    loader = {
      systemd-boot.enable = false;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };

      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        font = "${pkgs.hack-font}/share/fonts/hack/Hack-Regular.ttf";
        fontSize = 24;
        extraEntries = ''
          menuentry 'System setup' $menuentry_id_option 'uefi-firmware' {
            fwsetup
          }
        '';
      };

    };

    supportedFilesystems = [ "ntfs" ];
  };
}