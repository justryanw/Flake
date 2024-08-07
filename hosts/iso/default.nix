# Generate ISO
# nix run nixpkgs#nixos-generators -- --format iso --flake .#iso -o result

{ lib, modulesPath, ... }: {
  imports = [
    ../../configuration.nix
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  bootloader.grub.enable = lib.mkForce false;
  networking.networkmanager.enable = true;
  networking.wireless.enable = lib.mkImageMediaOverride false;

  services.displayManager.autoLogin = {
    enable = true;
    user = "ryan";
  };

  enabledUsers.helen.enable = lib.mkForce false;
}