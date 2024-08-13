{ self, config, system, ... } @ inputs: {
  imports = [
    ../../configuration.nix
    ./all-hardware.nix
  ];

  modules = {
    gaming.enable = false;
    users.helen.enable = false;
    amd.enable = false;
    disko.enable = true;
  };

  disko.devices.disk.${config.networking.hostName}.device = "/dev/sda";

  services = {
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
    xserver.videoDrivers = [ "qxl" ];
  };

  boot.initrd.availableKernelModules = [ "9p" "9pnet_virtio" "xhci_pci" "usb_storage" "usbhid" "sd_mod" ];

  environment = {
    variables.GC_INITIAL_HEAP_SIZE = "1M";

    systemPackages = with self.packages.${system}; [
      write-usb
      run-usb
      check-uefi
      install-nixos
    ];
  };

  networking.hostName = "usb";

  system.stateVersion = "24.11";
}
