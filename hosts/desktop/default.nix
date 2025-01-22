{ config, pkgs, ... }:
{
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
  };

  disko.devices.disk.${config.networking.hostName}.device =
    "/dev/disk/by-id/nvme-WDS500G3X0C-00SJG0_2018GE480508";

  boot.loader.grub = {
    gfxmodeEfi = "3440x1440";
    useOSProber = true;
  };

  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ "ryan" ];
  environment.systemPackages = [ pkgs.docker-compose ];

  hardware.flirc.enable = true;

  networking = {
    hostName = "desktop";

    firewall = {
      # Mindustry
      allowedTCPPorts = [ 6567 ];
      allowedUDPPorts = [ 6567 ];
    };
  };

  system.stateVersion = "24.11";

  services = {
    xmrig = {
      enable = true;
      settings = {
        autosave = true;
        cpu = {
          enabled = true;
          rx = {
            threads = 6;
          };
        };
        opencl = false;
        cuda = false;
        pools = [
          {
            url = "pool.hashvault.pro:443";
            user = "84jLA5hxrGkNrj7kLpZt519MCWwPyMj8oBt9ikTAqoZvG8Qcd3PFGmkZNDPDT9jk7FZ39VzNMgqzFXLHEKvs9pcF6L8DaTm";
            pass = "desktop";
            keepalive = true;
            tls = true;
          }
        ];
      };
    };
  };
}
