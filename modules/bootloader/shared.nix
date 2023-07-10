{ pkgs, ... }: {
  boot = {
    loader = {
      systemd-boot.enable = false;

      grub = {
        enable = true;
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

    kernel.sysctl."vm.max_map_count" = 1048576;

    supportedFilesystems = [ "ntfs" ];
  };
}