{ pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "Kevin";
}
