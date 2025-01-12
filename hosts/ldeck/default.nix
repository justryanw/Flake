{ ... }:
{
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
  ];

  modules.steamos.enable = true;

  networking.hostName = "ldeck";
  system.stateVersion = "25.01";
}
