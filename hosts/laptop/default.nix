{ ... }: {
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
  ];

  programs.nh.flake = "/home/ryan/flake";

  boot.loader.grub.gfxmodeEfi = "1920x1080";

  networking.hostName = "laptop";
  system.stateVersion = "22.11";
}
