{ pkgs, lib, ... } @ inputs: {
  imports = [ ./modules ];

  config = {
    modules = {
      grub.enable = lib.mkDefault true;
      amd.enable = lib.mkDefault true;
      gaming.enable = lib.mkDefault true;
      gnome.enable = lib.mkDefault true;
      mullvad.enable = lib.mkDefault true;
    };

    nix.settings = {
      trusted-users = [ "root" "@wheel" ];
      experimental-features = [ "nix-command" "flakes" ];
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
    };

    services.openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
      openFirewall = false;
    };

    environment = {
      pathsToLink = [ "/share/zsh" ];

      systemPackages = with pkgs; [
        nixd
        nixpkgs-fmt
        git
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
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBl7qYlcDcv/3dkMxX3MkKcTdfxCdEKuGUxbEzfuAZ9F ryan@Pavilion"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPGg4nR3v4p0/0/8hKsIqRy2YGFAvMlGuDXCDGuA++FR nix-on-droid@localhost"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJbOCsQ0JHfnFgOanl56w/y1o3dhHtOnkgqW8aTBxWuc ryan.walker@LAP00396"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKHT6zqmuClgoKRyhqJWvImrJU0nnS8rOIGgGB9RE0ta deck@steamdeck"
    ];
  };
}
