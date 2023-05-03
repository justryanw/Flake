{ ... }: {
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "NixVM";
}
