{ pkgs, config, lib, gpuIDs, ... }:
let
  looking-glass-client-overlay = (final: prev: {
    looking-glass-client = prev.looking-glass-client.overrideAttrs (old: {
      version = "B7-rc1";

      src = prev.fetchFromGitHub {
        owner = "gnif";
        repo = "LookingGlass";
        rev = "4d45b3807f1717d8eca0718253de545c0288a918";
        sha256 = "sha256-ne1Q+67+P8RHcTsqdiSSwkFf0g3pSNT91WN/lsSzssU=";
        fetchSubmodules = true;
      };

      # decorations seem to be broken in b7-rc1
      # buildInputs = old.buildInputs ++ [ pkgs.libdecor ];

      # cmakeFlags = old.cmakeFlags ++ [ "-DENABLE_LIBDECOR=ON" ];
    });
  });

  cfg = config.gamingVM;
in
{
  options.gamingVM = {
    enable = lib.mkEnableOption "Enable gaming vm";

    gpuIDs = lib.mkOption {
      default = "";
      description = "ids of gpu to passthrough";
    };
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [ looking-glass-client-overlay ];

    users.users.ryan.extraGroups = [ "libvirtd" ];

    environment.systemPackages = with pkgs; [
      virt-viewer
      spice
      spice-gtk
      spice-protocol
      win-virtio
      win-spice
      looking-glass-client
    ];

    programs = {
      virt-manager.enable = true;
    };

    boot = {
      initrd.kernelModules = [
        "vfio"
        "vfio_pci"
        "vfio_pci_core"
        "vfio_iommu_type1"
      ];

      kernelParams = [
        "amd_iommu=on"
        ("vfio-pci.ids=" + pkgs.lib.concatStringsSep "," cfg.gpuIDs)
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
  };
}
