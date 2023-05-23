{ pkgs, state, ... }: {
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
      layout = "gb";
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    printing.enable = true;

    avahi = {
      enable = true;
      nssmdns = true;
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
          "tcp://longseason.1200bps.xyz:13121"
          "tls://185.175.90.87:43006"
        ];
      };
    };

    flatpak.enable = true;

    udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  };

  security = {
    rtkit.enable = true;
    sudo.wheelNeedsPassword = false;
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
      ];
    };
  };

  programs = {
    zsh.enable = true;
    steam.enable = true;
    dconf.enable = true;
  };

  environment = {
    shells = with pkgs; [ zsh ];
    pathsToLink = [ "/share/zsh" ];

    systemPackages = (with pkgs; [
      tldr
      nil
      nixpkgs-fmt
      waypipe
    ]) ++ (with pkgs.gnomeExtensions; [
      appindicator
    ]) ++ (with pkgs.gnome; [
      gnome-software
    ]);

    gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
      epiphany
    ]) ++ (with pkgs.gnome; [
      totem
      cheese
      yelp
    ]);
  };

  networking = {
    hosts = {
      "200:e69b:f58b:f5f1:c3d3:e5cc:8512:12c" = [ "desktop" ];
      "202:8699:42dd:e354:50c5:5a7e:610b:1a18" = [ "laptop" ];
      "200:d13b:15e2:865:7c39:ad3f:fff6:cbbd" = [ "work" ];
      "200:5ec2:56e1:400a:a0e6:3266:d737:d89d" = [ "vm" ];
      "200:79ec:fa57:9588:9683:775e:d0ad:c6b9" = [ "kevin" ];
    };

    firewall = {
      extraCommands = ''
        iptables -A nixos-fw -s 192.168.0.0/24 -j nixos-fw-accept
        ip6tables -A nixos-fw -s desktop -j nixos-fw-accept
        ip6tables -A nixos-fw -s laptop -j nixos-fw-accept
        ip6tables -A nixos-fw -s work -j nixos-fw-accept
        ip6tables -A nixos-fw -s vm -j nixos-fw-accept
        ip6tables -A nixos-fw -s kevin -j nixos-fw-accept
      '';
      extraStopCommands = ''
        iptables -D nixos-fw -s 192.168.0.0/24 -j nixos-fw-accept || true
        ip6tables -D nixos-fw -s desktop -j nixos-fw-accept || true
        ip6tables -D nixos-fw -s laptop -j nixos-fw-accept || true
        ip6tables -D nixos-fw -s work -j nixos-fw-accept || true
        ip6tables -D nixos-fw -s vm -j nixos-fw-accept || true
        ip6tables -D nixos-fw -s kevin -j nixos-fw-accept || true
      '';
    };
  };

  nixpkgs.config.allowUnfree = true;

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
  };
}
