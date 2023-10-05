{ pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  boot = {
    loader.grub = {
      gfxmodeEfi = "3440x1440";
      minegrub-theme = {
        enable = true;
        splash = "100% Flakes!";
      };
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking.hostName = "Desktop";
}
