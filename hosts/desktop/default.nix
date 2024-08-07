{ ... }: {
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "desktop";
  system.stateVersion = "23.05";
}
