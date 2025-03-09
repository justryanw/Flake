{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
  ];

  modules = {
    disko.enable = true;

    gaming-vm = {
      enable = false;

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

    xmrig = {
      enable = false;
      name = "desktop";
      threads = 6;
    };
  };

  disko.devices.disk.${config.networking.hostName}.device = "/dev/disk/by-id/nvme-WDS500G3X0C-00SJG0_2018GE480508";

  boot.loader.grub = {
    gfxmodeEfi = "3440x1440";
    useOSProber = false;
  };

  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = ["ryan"];
  environment.systemPackages = [pkgs.docker-compose];

  hardware.flirc.enable = true;

  networking = {
    hostName = "desktop";

    firewall = {
      # Mindustry
      allowedTCPPorts = [6567];
      allowedUDPPorts = [6567];
    };
  };

  system.stateVersion = "24.11";

  services = {
    zerotierone = {
      enable = true;
      joinNetworks = ["d3ecf5726d350938"];
    };

    ollama = {
      enable = true;
      loadModels = [
        "deepseek-r1:1.5b"
        "deepseek-r1:7b"
        "deepseek-r1:14b"
      ];
    };

    open-webui.enable = true;
  };
}
