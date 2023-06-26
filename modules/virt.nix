let
  # GTX 1070
  gpuIDs = [
    "10de:1b81" # Graphics
    "10de:10f0" # Auido
  ];
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
      "vfio_virqfd"
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
