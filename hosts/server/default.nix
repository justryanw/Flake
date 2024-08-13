{ pkgs, ... }: {
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
  ];

  disko.devices.disk.main.device = "/dev/nvme0n1";

  modules = {
    gaming.enable = false;
    gnome.enable = false;
    users.helen.enable = false;
    amd.enable = false;
  };

  networking = {
    hostName = "server";

    wireless.iwd = {
      enable = true;
      settings = {
        IPv6.Enabled = true;
        Settings.AutoConnect = true;
      };
    };
  };

  system.stateVersion = "24.11";
}
