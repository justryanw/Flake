{ lib, modulesPath, ... }: {
  imports = [
    ../../configuration.nix
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  bootloader.grub.enable = lib.mkForce false;
}