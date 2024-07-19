{ config, lib, ... }: {
  imports = [ ./hardware-configuration.nix ];

  boot = {
    loader.grub.gfxmodeEfi = "1920x1080";
  };

  networking.hostName = "pavilion";

  services.xserver.videoDrivers = lib.mkForce [ "nvidia" ];

  hardware = {
    graphics = {
      enable = true;
    };

    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;

        prime = {
          sync.enable = true;

          amdgpuBusId = "PCI:5:0:0";
          nvidiaBusId = "PCI:1:0:0";
        };
    };
  };
}
