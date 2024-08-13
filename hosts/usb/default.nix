{ nixpkgs, lib, ... }: {
  imports = [
    ../../configuration.nix
    "${nixpkgs}/nixos/modules/profiles/all-hardware"
  ];

  modules = {
    gaming.enable = false;
    users.helen.enable = false;
    amd.enable = false;
  };

  disko.devices.disk.main.device = "/dev/sda";

  services = {
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
    xserver.videoDrivers = [ "qxl" ];
  };

  boot.initrd = {
    availableKernelModules = [ "9p" "9pnet_virtio" "xhci_pci" "usb_storage" "usbhid" "sd_mod" ];
    kernel.sysctl."vm.overcommit_memory" = "1";
  };

  environment.variables.GC_INITIAL_HEAP_SIZE = "1M";

  networking = {
    hostName = "usb";
    wireless = {
      enable = lib.mkDefault true;
      userControlled.enable = true;
    };
  };

  systemd.services.wpa_supplicant.wantedBy = lib.mkOverride 50 [ ];

  system.stateVersion = "24.11";
}
