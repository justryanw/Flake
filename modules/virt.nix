let
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
in
{ config, pkgs, ... }:

{
  users.users.ryan.extraGroups = [ "libvirtd" ];

  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
    looking-glass-client
  ];

  boot = {
    initrd.kernelModules = [
      "vfio_pci"
      "vfio"
      "vfio_iommu_type1"
      # "vfio_virqfd"
    ];

    kernelParams = [
      "amd_iommu=on"
      ("vfio-pci.ids=" + pkgs.lib.concatStringsSep "," gpuIDs)
    ];
  };


  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        ovmf.enable = true;
        runAsRoot = false;
      };
    };
    spiceUSBRedirection.enable = true;
  };

  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 ryan qemu-libvirtd -"
  ];

  hardware.opengl.enable = true;

  services = {
    spice-vdagentd.enable = true;
  };
}
