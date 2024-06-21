{ pkgs, lib, ... }: {
  imports = [ ./hardware-configuration.nix ../../modules/virt.nix ];

  boot = {
    loader.grub = {
      gfxmodeEfi = "3440x1440";
      fontSize = 32;
    };

    kernelPackages = pkgs.linuxPackages_latest;
  };

  services = {
    xserver.videoDrivers = [ "amdgpu" ];

    monero.dataDir = "/home/Monero";
  };

  networking.hostName = "Desktop";

  gamingVM = {
    enable = true;

    # GTX 1070
    gpuIDs = [
      "10de:1b81" # Graphics
      "10de:10f0" # Auido
    ];

    # RX 6800 XT
    # gpuIDs = [
    #   "1002:73bf"
    #   "1002:ab28"
    # ];

    # RX 7900 XTX
    # gpuIDs = [
    #   "1002:744c"
    #   "1002:ab30"
    #   "1002:7446"
    #   "1002:7444"
    # ];
  };

  virtualisation = {
    waydroid.enable = false;

    docker = {
      enable = true;
      package =  pkgs.docker_25;
    };
  };

  users.users.ryan.extraGroups = [ "docker" "adbusers" ];

  programs.adb.enable = true;
  services.udev.packages = [
    pkgs.android-udev-rules
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "valheim-server"
    "steamworks-sdk-redist"
  ];

  services.valheim = {
    enable = true;
    serverName = "Tombolheim";
    worldName = "Tombolheim";
    openFirewall = true;
    password = "Levitt";
  };
}
