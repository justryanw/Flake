{ config, pkgs, ... }: {
  imports = [
    ../../configuration.nix
    ./hardware-configuration.nix
  ];

  disko.devices.disk.${config.networking.hostName}.device = "/dev/disk/by-id/nvme-WDC_WDS250G2B0C-00PXH0_21140K457811";

  modules = {
    gaming.enable = false;
    gnome.enable = false;
    users.helen.enable = false;
    amd.enable = false;
    disko.enable = true;
    homepage.enable = true;
    glances.enable = true;
  };

  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/40d5fc81-5852-42d1-8bc2-befba6d438b4";
    fsType = "bcachefs";
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
    };
  };

  users = {
    groups.data = { };
    users.ryan.extraGroups = [ "data" ];
  };

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
  };

  system.stateVersion = "24.11";
}
