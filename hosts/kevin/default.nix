{ pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "kevin";
}
