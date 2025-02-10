{
  pkgs,
  inputs,
  lib,
  config,
  ...
}:
{
  imports = [ ./modules ];

  config = {
    modules = {
      grub.enable = lib.mkDefault true;
      amd.enable = lib.mkDefault true;
      gaming.enable = lib.mkDefault true;
      gnome.enable = lib.mkDefault true;
      mullvad.enable = lib.mkDefault true;
    };

    nix = {
      registry.pkgs = {
        from = {
          id = "pkgs";
          type = "indirect";
        };
        flake = inputs.nixpkgs-unfree;
      };

      settings = {
        trusted-users = [
          "root"
          "@wheel"
        ];
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        builders-use-substitutes = true;
        substituters = [
          "https://justryanw.cachix.org"
          "ssh://eu.nixbuild.net"
        ];
        trusted-public-keys = [
          "justryanw.cachix.org-1:oan1YuatPBqGNFEflzCmB+iwLPtzq1S1LivN3hUzu60="
          "nixbuild.net/ACT8PT-1:xsXpIjcF8wW2pTTAaNYZzfDNcYZkG7ICcY+/o5tNCGE="
        ];
      };

      distributedBuilds = true;
      buildMachines = [
        {
          hostName = "eu.nixbuild.net";
          system = "x86_64-linux";
          maxJobs = 100;
          protocol = "ssh-ng";
          sshUser = "ryan";
          sshKey = "/home/ryan/.ssh/id_ed25519";
          supportedFeatures = [
            "benchmark"
            "big-parallel"
          ];
        }
      ];

      optimise.automatic = true;

      extraOptions = ''
        min-free = ${toString (10 * 1024 * 1024 * 1024)} # Start garbage collection when less than 10Gb is free.
        max-free = ${toString (50 * 1024 * 1024 * 1024)} # Stop when more than 50Gb is free.
      '';
    };

    nixpkgs.config.allowUnfree = true;

    console.keyMap = "uk";

    security = {
      sudo.wheelNeedsPassword = false;
    };

    time.timeZone = "Europe/London";
    i18n.defaultLocale = "en_GB.UTF-8";

    programs = {
      zsh.enable = true;

      nh = {
        enable = true;
        flake = lib.mkDefault "/home/ryan/flake";
      };

      nix-ld = {
        enable = true;
        package = pkgs.nix-ld-rs;
      };

      dconf.enable = true;

      ssh.extraConfig = ''
        Host eu.nixbuild.net
          PubkeyAcceptedKeyTypes ssh-ed25519
          ServerAliveInterval 60
          IPQoS throughput
          IdentityFile /home/ryan/.ssh/id_ed25519
      '';
    };

    services = {
      openssh = {
        enable = true;
        settings.PasswordAuthentication = false;
        openFirewall = false;

        knownHosts = {
          nixbuild = {
            hostNames = [ "eu.nixbuild.net" ];
            publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPIQCZc54poJ8vqawd8TraNryQeJnvH1eLpIDgbiqymM";
          };
        };
      };

      flatpak.enable = lib.mkIf config.modules.gnome.enable true;

      keyd = {
        enable = true;
        keyboards.default = {
          ids = [ "*" ];
          settings.main.capslock = "esc";
        };
      };
    };

    environment = {
      pathsToLink = [ "/share/zsh" ];

      systemPackages = with pkgs; [
        git
        nixd
        nixfmt-rfc-style
        nix-output-monitor
        parallel
        jq
        btop
      ];
    };

    users.users.root.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG2+1HkbVk10Wt5I5l6iPkXcAUCLQ8EQ4qs9MYIXXlqK ryan@Desktop"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH/tpdZr5X8NgBldgtviMMgNOUWDRckjZNYIhIk/CX/h ryan@Laptop"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICST/XcgBSr878OmFH69VvIC+wghUMTwijmP1NdExqVv ryan@server"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIA4kZYqe2d4BUllwNNBT1vydbrObxFs4lSkYDkkTRq/q ryan@usb"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINDGUsv2xnB04Jh+M15As1jJs/MvtnAqeJ5FsSaXGv3S ryanjwalker2001@gmail.com"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDbYyLHLWRdv9djFcSVIKmUFVtV35Ztj4t8iVLL+A/Z+ kevin@nixos"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICWIiPRXGHVkhx1O/YDNOJfFQADhld2CxQKRKCnW1Fhv ryan@NixVM"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMdiQCqmkZU2IXcahakRFfWcOiD2nTU6T854Y81nP05u ryan@pavilion"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID8Q2R9QZR9ToO+p3vMlgDEQbuAHdLcec2JAY7E2CWVQ helen@pavilion"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPGg4nR3v4p0/0/8hKsIqRy2YGFAvMlGuDXCDGuA++FR nix-on-droid@localhost"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKHT6zqmuClgoKRyhqJWvImrJU0nnS8rOIGgGB9RE0ta deck@steamdeck"
    ];
  };
}
