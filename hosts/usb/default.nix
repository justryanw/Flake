{ pkgs, ... }: {
  imports = [
    ../../configuration.nix
  ];

  modules = {
    gaming.enable = false;
    users.helen.enable = false;
    amd.enable = false;
  };

  networking.hostName = "usb";

  system.stateVersion = "24.11";
}
