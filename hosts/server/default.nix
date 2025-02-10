{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
    inputs.nix-minecraft.nixosModules.minecraft-servers
  ];

  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  modules = {
    gaming.enable = false;
    gnome.enable = false;
    amd.enable = false;
    disko.enable = true;
    homepage.enable = true;
    glances.enable = true;

    xmrig = {
      enable = true;
      name = "server";
      threads = 8;
    };
  };

  disko.devices.disk.${config.networking.hostName}.device =
    "/dev/disk/by-id/nvme-WDC_WDS250G2B0C-00PXH0_21140K457811";

  fileSystems = {
    "/data/media" = {
      device = "/dev/disk/by-uuid/42bd991a-dae7-4673-ab49-36b5979b7de6";
      fsType = "btrfs";
    };
    "/data/immich" = {
      device = "/dev/disk/by-uuid/afa858f5-8400-40d3-9405-e18746ff5f4c";
      fsType = "btrfs";
    };
  };

  hardware.graphics = {
    enable = true;
    # View usage
    # sudo nix shell nixpkgs#intel-gpu-tools -c intel_gpu_top
    # sudo nix run nixpkgs#nvtopPackages.intel
    extraPackages = with pkgs; [
      # VAAPI
      intel-media-driver
      # intel-vaapi-driver
      vaapiVdpau
      libvdpau-va-gl

      # Tonemapping
      intel-compute-runtime
      # QSV
      intel-media-sdk
    ];
  };

  nixpkgs.config.permittedInsecurePackages = [
    # sonarr
    "dotnet-sdk-6.0.428"
    "aspnetcore-runtime-6.0.36"
  ];

  services = {
    # Enable IPv6 and remote access from cli
    # https://forum.jellyfin.org/printthread.php?tid=7357
    jellyfin = {
      enable = true;
      user = "ryan";
      group = "data";
    };

    transmission = {
      enable = true;
      user = "ryan";
      group = "data";
      settings = {
        download-dir = "/data/media/torrents";
        incomplete-dir = "/data/media/torrents/incomplete";
        watch-dir = "/data/media/torrents/watch";
        watch-dir-enabled = true;
        rpc-bind-address = "::";
        rpc-whitelist-enabled = false;
        download-queue-enabled = false;
        speed-limit-up-enabled = true;
        speed-limit-up = 10000;
        speed-limit-down-enabled = true;
        speed-limit-down = 50000;
      };
      webHome = pkgs.flood-for-transmission;
    };

    radarr = {
      enable = true;
      user = "ryan";
      group = "data";
    };

    sonarr = {
      enable = true;
      user = "ryan";
      group = "data";
    };

    prowlarr.enable = true;
    jellyseerr.enable = true;

    samba = {
      enable = true;
      # wont let you connect to a pulbic share without a user existing
      # sudo smbpasswd -a ryan
      settings = {
        media = {
          path = "/data/media";
          "read only" = true;
          browseable = "yes";
          "guest ok" = "yes";
          comment = "Media share.";
        };
        watch = {
          path = "/data/media/torrents/watch";
          "read only" = false;
          browseable = "yes";
          "guest ok" = "yes";
          comment = "Wriateable watch dir.";
        };
      };
    };

    immich = {
      enable = true;
      mediaLocation = "/data/immich";
      host = "::";
      port = 2283;
      machine-learning.enable = true;
    };

    monero = {
      enable = true;
      dataDir = "/data/media/monero";
    };
  };

  users = {
    groups.data = { };
    users = {
      ryan.extraGroups = [ "data" ];
      immich.extraGroups = [
        "video"
        "render"
      ];
    };
    extraGroups.docker.members = [ "ryan" ];
  };

  virtualisation.docker.enable = true;
  environment.systemPackages = [ pkgs.docker-compose ];

  systemd.tmpfiles.rules = [
    "d /data 775 root data"
    "d /data/media/torrents 775 ryan data"
    "d /data/media/torrents/incomplete 775 ryan data"
    "d /data/media/torrents/watch 775 ryan data"
    "d /data/media/torrents/radarr 775 ryan data"
    "d /data/media/torrents/sonarr 775 ryan data"
    "d /data/media/movies 775 ryan data"
    "d /data/media/shows 775 ryan data"
    "d /data/immich 775 immich immich"
  ];

  networking = {
    hostName = "server";

    wireless.iwd = {
      enable = true;
      settings = {
        IPv6.Enabled = true;
        Settings.AutoConnect = true;
      };
    };

    firewall = {
      # Minecraft
      allowedTCPPorts = [ 25565 ];
      allowedUDPPorts = [ 25565 ];
    };
  };

  system.stateVersion = "24.11";
}
