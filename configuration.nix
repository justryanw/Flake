# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’)

{ config, pkgs, lib, ... }:
let
  # nix-software-center = (import (pkgs.fetchFromGitHub {
  #   owner = "vlinkz";
  #   repo = "nix-software-center";
  #   rev = "0.1.0";
  #   sha256 = "d4LAIaiCU91LAXfgPCWOUr2JBkHj6n0JQ25EqRIBtBM=";
  # })) { };
in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # ./gnome.nix
      # ./kde.nix
      # <home-manager/nixos>
      # ./ryan.nix
      # /home/ryan/config.nix
    ];
    
    
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  
  
  # environment.systemPackages = with pkgs; [
  # 	gnome-extension-manager
  #   gnome.gnome-tweaks
  # ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";



  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
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

  services.xserver.enable = true;

  services.xserver = {
    layout = "gb";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ryan = {
    isNormalUser = true;
    description = "Ryan";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # home-manager.useGlobalPkgs = true;

  services.flatpak.enable = true;
  # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # services.monero = {
  #   enable = false;
  #   limits = {
  #     threads = 1;
  #   };
  # };

  # services.avahi = {
  #   enable = true;
  #   nssmdns = true;
  #   openFirewall = true;
  # };

  # programs.steam.enable = true;

  # Enable networking
  networking = {
    networkmanager = {
      enable = true;
      unmanaged = [ "interface-name:ve-*" ];
    };

    nat = {
      enable = true;
      internalInterfaces = [ "ve-+" ];
      externalInterface = "wlp2s0";
    };
  };

  # containers.vpn = {
  #   autoStart = true;
  #   privateNetwork = true;
  #   hostAddress = "192.168.0.110";
  #   localAddress = "192.168.0.111";
  #   enableTun = true;

  #   config = { config, pkgs, ... }: {

  #     services.openvpn.servers = {
  #       main = {
  #         config = '' config /root/uk_london-aes256-udp.ovpn '';
  #         authUserPass.username = "vpn97285351";
  #         authUserPass.password = "Silencer-Glitch8-Yield";
  #       };
  #     };

  #     systemd.tmpfiles.rules = [
  #       "d /home/Torrents 775 transmission transmission"
  #     ];

  #     services.transmission = {
  #       enable = true;
  #       settings = {
  #         download-dir = "/home/Torrents";
  #         incomplete-dir = "/home/Torrents";
  #         rpc-bind-address = "192.168.0.111";
  #         rpc-whitelist = "192.168.0.110";
  #       };
  #       openRPCPort = true;
  #     };

  #     networking.firewall.enable = false;

  #     system.stateVersion = "22.11";

  #     environment.etc."resolv.conf".text = "nameserver 8.8.8.8";

  #   };
  # };

  programs.zsh.enable = true;

  users.defaultUserShell = pkgs.zsh;

  environment = {
    shells = with pkgs; [ zsh ];
    pathsToLink = [ "/share/zsh" ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # lm_sensors
    tldr
    # nix-software-center
    helix
  ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };
}
