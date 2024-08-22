{ config, ... }: {
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
  ];

  modules = {
    disko.enable = true;

    gaming-vm = {
      enable = false;

      # GTX 1070
      gpuIDs = [
        "10de:1b81" # Graphics
        "10de:10f0" # Auido
      ];

      # RX 6800 XT
      # gpuIDs = [
      #   "1002:73bf"
      #   "1002:ab28"
      # ];

      # RX 7900 XTX
      # gpuIDs = [
      #   "1002:744c"
      #   "1002:ab30"
      #   "1002:7446"
      #   "1002:7444"
      # ];
    };
  };

  disko.devices.disk.${config.networking.hostName}.device = "/dev/disk/by-id/nvme-WDS500G3X0C-00SJG0_2018GE480508";

  boot.loader.grub = {
    gfxmodeEfi = "3440x1440";
    useOSProber = true;
  };

  networking.hostName = "desktop";
  system.stateVersion = "24.11";
}
