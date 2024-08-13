{ pkgs, ... }: {
  imports = [
    ../../configuration.nix
  ];

  modules = {
    gaming.enable = false;
    users.helen.enable = false;
    amd.enable = false;
  };

  disko.devices.disk.main.device = "/dev/sda";

  services.qemuGuest.enable = true;

  networking.hostName = "usb";

  system.stateVersion = "24.11";
}
