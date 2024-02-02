{ pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  boot = {
    loader.grub.gfxmodeEfi = "3440x1440";
    kernelPackages = pkgs.linuxPackages_latest;
  };

  services = {
    xserver.videoDrivers = [ "amdgpu" ];

    monero.dataDir = "/home/Media/Monero";
  };

  networking.hostName = "Desktop";

  # somehow messes with yggdrasil?
  # virtualisation.waydroid.enable = true;
}
