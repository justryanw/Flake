{ ... }: {
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
  ];

  programs.nh.flake = "/home/ryan/flake";

  boot.loader.grub.gfxmodeEfi = "3440x1440";

  networking.hostName = "desktop";
  system.stateVersion = "23.05";
}
