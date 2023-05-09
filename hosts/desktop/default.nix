{ pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  boot = {
    loader.grub.gfxmodeEfi = "3440x1440";
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking.hostName = "Desktop";
}
