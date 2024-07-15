{ pkgs, lib, state, inputs, system, config, ... }:
let
  nix-software-center = inputs.nix-software-center.packages.${system}.nix-software-center;
in
{
  system.stateVersion = state;

  console = {
    # keyMap = "uk";
    useXkbConfig = true;
  };

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  sound.enable = true;

  hardware = {
    pulseaudio.enable = false;
    bluetooth.enable = true;
  };

  services = {
    xserver = {
      enable = true;
      xkb.layout = "gb";
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    ratbagd.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    printing.enable = true;

    avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        addresses = true;
        userServices = true;
      };
    };

    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
      openFirewall = false;
    };

    yggdrasil = {
      enable = true;
      persistentKeys = true;
      group = "wheel";
      openMulticastPort = true;
      settings = {
        Peers = [
          "tls://185.175.90.87:43006"
        ];
        Listen = [
          "tls://[::]:0"
        ];
        MulticastInterfaces = [
          {
            Regex = ".*";
            Beacon = true;
            Listen = true;
            Port = 9001;
            Priority = 0;
          }
        ];
      };
    };

    flatpak.enable = true;

    udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  };

  # fix for https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;

  security = {
    rtkit.enable = true;
    sudo.wheelNeedsPassword = false;
  };

  programs = {
    zsh.enable = true;
    steam.enable = true;
    dconf.enable = true;
  };

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "DroidSansMono" ]; })
    ];
  };

  environment = {
    shells = with pkgs; [ zsh ];
    pathsToLink = [ "/share/zsh" ];

    # Native Wayalnd for Chromium based apps
    # sessionVariables.NIXOS_OZONE_WL = "1";

    systemPackages = (with pkgs; [
      tldr
      nil
      nixpkgs-fmt
      nix-software-center
      waypipe
      gamescope
      iperf
      btrfs-progs
      fzf
    ]) ++ (with pkgs.gnomeExtensions; [
      appindicator
    ]) ++ (with pkgs.gnome; [
      gnome-software
      gnome-remote-desktop
    ]);

    gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
      epiphany
    ]) ++ (with pkgs.gnome; [
      cheese
      yelp
    ]);

    sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" (with pkgs.gst_all_1; [
      gst-plugins-good
      gst-plugins-bad
      gst-plugins-ugly
      gst-libav
    ]);

  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.ryan = {
      isNormalUser = true;
      description = "Ryan";
      extraGroups = [ "networkmanager" "wheel" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG2+1HkbVk10Wt5I5l6iPkXcAUCLQ8EQ4qs9MYIXXlqK ryan@Desktop"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINDGUsv2xnB04Jh+M15As1jJs/MvtnAqeJ5FsSaXGv3S ryanjwalker2001@gmail.com"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH/tpdZr5X8NgBldgtviMMgNOUWDRckjZNYIhIk/CX/h ryan@Laptop"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDbYyLHLWRdv9djFcSVIKmUFVtV35Ztj4t8iVLL+A/Z+ kevin@nixos"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICWIiPRXGHVkhx1O/YDNOJfFQADhld2CxQKRKCnW1Fhv ryan@NixVM"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBl7qYlcDcv/3dkMxX3MkKcTdfxCdEKuGUxbEzfuAZ9F ryan@Pavilion"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPGg4nR3v4p0/0/8hKsIqRy2YGFAvMlGuDXCDGuA++FR nix-on-droid@localhost"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJbOCsQ0JHfnFgOanl56w/y1o3dhHtOnkgqW8aTBxWuc ryan.walker@LAP00396"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKHT6zqmuClgoKRyhqJWvImrJU0nnS8rOIGgGB9RE0ta deck@steamdeck"
      ];
    };
  };

  networking = {
    hosts = {
      "200:f788:a3a9:56ae:d341:e3f7:c7f:c771" = [ "desktop" ];
      "202:8699:42dd:e354:50c5:5a7e:610b:1a18" = [ "laptop" ];
      "200:d13b:15e2:865:7c39:ad3f:fff6:cbbd" = [ "work" ];
      "200:5ec2:56e1:400a:a0e6:3266:d737:d89d" = [ "vm" ];
      "200:79ec:fa57:9588:9683:775e:d0ad:c6b9" = [ "kevin" ];
      "200:6e2:97ec:3a8a:eb8a:174e:e4dc:7ca1" = [ "pavilion" ];
      "201:e7ad:b13b:b71a:9ef2:123e:1e86:ffe0" = [ "phone" ];
      "201:e145:88cf:f359:a185:19a7:9772:94a" = [ "kev-tv" ];
      "201:f5ff:565:4fef:6597:9c51:654e:f08a" = [ "helen-phone" ];
      "201:1116:41e5:2a9d:23fe:c842:5a84:5f7c" = [ "tvbox" ];
      "192.168.0.198" = [ "inspired" ];
    };

    firewall = {
      allowedTCPPorts = [ 9001 8766 27011 38000 ];
      allowedUDPPorts = [ 9001 8766 27011 38000 ];

      extraCommands = ''
        iptables -A nixos-fw -s 192.168.0.0/24 -j nixos-fw-accept
        ip6tables -A nixos-fw -s desktop -j nixos-fw-accept
        ip6tables -A nixos-fw -s laptop -j nixos-fw-accept
        ip6tables -A nixos-fw -s work -j nixos-fw-accept
        ip6tables -A nixos-fw -s vm -j nixos-fw-accept
        ip6tables -A nixos-fw -s kevin -j nixos-fw-accept
        ip6tables -A nixos-fw -s pavilion -j nixos-fw-accept
        ip6tables -A nixos-fw -s phone -j nixos-fw-accept
        ip6tables -A nixos-fw -s kev-tv -j nixos-fw-accept
        ip6tables -A nixos-fw -s helen-phone -j nixos-fw-accept
        ip6tables -A nixos-fw -s tvbox -j nixos-fw-accept
        ip6tables -A nixos-fw -s fe80::eafb:1cff:fe43:54cb -j nixos-fw-accept
      '';
      extraStopCommands = ''
        iptables -D nixos-fw -s 192.168.0.0/24 -j nixos-fw-accept || true
        ip6tables -D nixos-fw -s desktop -j nixos-fw-accept || true
        ip6tables -D nixos-fw -s laptop -j nixos-fw-accept || true
        ip6tables -D nixos-fw -s work -j nixos-fw-accept || true
        ip6tables -D nixos-fw -s vm -j nixos-fw-accept || true
        ip6tables -D nixos-fw -s kevin -j nixos-fw-accept || true
        ip6tables -D nixos-fw -s pavilion -j nixos-fw-accept || true
        ip6tables -D nixos-fw -s phone -j nixos-fw-accept || true
        ip6tables -D nixos-fw -s kev-tv -j nixos-fw-accept || true
        ip6tables -D nixos-fw -s helen-phone -j nixos-fw-accept || true
        ip6tables -D nixos-fw -s tvbox -j nixos-fw-accept || true
        ip6tables -D nixos-fw -s fe80::eafb:1cff:fe43:54cb -j nixos-fw-accept || true
      '';
    };
  };

  nixpkgs.config = {
    allowUnfree = true;

    permittedInsecurePackages = [
      "openssl-1.1.1w"
      "nix-2.16.2"
    ];

    packageOverrides = pkgs: {
      steam = pkgs.steam.override {
        extraPkgs = pkgs: with pkgs; [
          xorg.libXcursor
          xorg.libXi
          xorg.libXinerama
          xorg.libXScrnSaver
          libpng
          libpulseaudio
          libvorbis
          stdenv.cc.cc.lib
          libkrb5
          keyutils
        ];
      };
    };
  };

  boot.extraModulePackages = with config.boot.kernelPackages; [
    # OBS Virtual Camera
    v4l2loopback
    # Archer T3U WiFi Adapter (doesnt seem to fix the adapter :( )
    # rtl88x2bu
  ];

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    distributedBuilds = true;

    # buildMachines = [{
    #   hostName = "laptop";
    #   sshUser = "ryan";
    #   sshKey = "/home/ryan/.ssh/id_ed25519";
    #   system = "x86_64-linux";
    #   maxJobs = 16;
    #   speedFactor = 1;
    #   supportedFeatures = ["big-parallel" "kvm" ];
    #   mandatoryFeatures = [ ];
    # }];

    settings = {
      trusted-users = [
        "root"
        "@wheel"
      ];

      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;

      substituters = [
        "https://cache.nixos.org/"
        "https://justryanw.cachix.org"
      ];

      trusted-public-keys = [
        "justryanw.cachix.org-1:oan1YuatPBqGNFEflzCmB+iwLPtzq1S1LivN3hUzu60="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
}
