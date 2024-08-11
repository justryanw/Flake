# Generate ISO
# nix run nixpkgs#nixos-generators -- --format iso --flake .#iso -o result

{ pkgs, lib, modulesPath, ... }:
let
  calamares-nixos-autostart = pkgs.makeAutostartItem { name = "io.calamares.calamares"; package = pkgs.calamares-nixos; };
in
{
  imports = [
    ../../configuration.nix
    "${modulesPath}/installer/cd-dvd/installation-cd-base.nix"
  ];

  modules = {
    grub.enable = false;
    gaming.enable = false;
    users = {
      helen.enable = false;
      ryan.enable = false;
      nixos.enable = true;
    };
    amd.enable = false;
  };

  programs.nh.flake = "/home/nixos/flake";

  nixpkgs.hostPlatform = "x86_64-linux";

  networking = {
    networkmanager.enable = true;
    wireless.enable = lib.mkImageMediaOverride false;
  };

  i18n.supportedLocales = [ "all" ];

  services = {
    displayManager.autoLogin = {
      enable = true;
      user = "nixos";
    };

    xserver.desktopManager.gnome = {
      favoriteAppsOverride = ''
        [org.gnome.shell]
        favorite-apps=[ 'firefox.desktop', 'nixos-manual.desktop', 'org.gnome.Console.desktop', 'org.gnome.Nautilus.desktop', 'io.calamares.calamares.desktop' ]
      '';

      extraGSettingsOverrides = ''
        [org.gnome.shell]
        welcome-dialog-last-shown-version='9999999999'
        [org.gnome.desktop.session]
        idle-delay=0
        [org.gnome.settings-daemon.plugins.power]
        sleep-inactive-ac-type='nothing'
        sleep-inactive-battery-type='nothing'
      '';
    };

    spice-vdagentd.enable = true;
    qemuGuest.enable = true;
    xe-guest-utilities.enable = pkgs.stdenv.hostPlatform.isx86;
  };

  virtualisation = {
    vmware.guest.enable = pkgs.stdenv.hostPlatform.isx86;
    hypervGuest.enable = true;
    virtualbox.guest.enable = false;
  };

  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';

  environment = {
    systemPackages = with pkgs; [
      libsForQt5.kpmcore
      calamares-nixos
      calamares-nixos-autostart
      calamares-nixos-extensions
      glibcLocales
    ];

    variables = {
      # Fix scaling for calamares on wayland
      QT_QPA_PLATFORM = "$([[ $XDG_SESSION_TYPE = \"wayland\" ]] && echo \"wayland\")";
    };
  };
}
