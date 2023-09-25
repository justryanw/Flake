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

  looking-glass-client-overlay = (final: prev: {
    looking-glass-client = prev.looking-glass-client.overrideAttrs (old: {
      src = prev.fetchFromGitHub {
        owner = "gnif";
        repo = "LookingGlass";
        rev = "193977895b7c654fdc26f68c8d5c45613692a036";
        sha256 = "sha256-qmIvVAM6eLGu+/1JZSrDnF2Et6AA34C8ZWSMCXFlvOs=";
        fetchSubmodules = true;
      };
    });
  });
in
{ pkgs, ... }: {
  nixpkgs.overlays = [ looking-glass-client-overlay ];

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
