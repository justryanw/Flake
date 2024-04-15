{ pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ../../modules/virt.nix ];

  environment.systemPackages = (with pkgs; [
    docker-compose
  ]);

  boot = {
    loader.grub.gfxmodeEfi = "3440x1440";
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

  # somehow messes with yggdrasil?
  virtualisation = {
    waydroid.enable = true;

    docker.enable = true;
  };

  users.users.ryan.extraGroups = [ "docker" ];
}
