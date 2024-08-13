{ pkgs, ... }: {
  imports = [
    ../../configuration.nix
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
    availableKernelModules = [ "virtio_net" "virtio_pci" "virtio_mmio" "virtio_blk" "virtio_scsi" "9p" "9pnet_virtio" ];
    kernelModules = [ "virtio_balloon" "virtio_console" "virtio_rng" "virtio_gpu" ];
  };

  networking.hostName = "usb";

  system.stateVersion = "24.11";
}
