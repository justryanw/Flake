{ ... }: {
  imports = [
    ./bootloader.nix
    ./gaming.nix
    ./gnome.nix
    ./graphics.nix
    ./yggdrasil.nix
    ./network.nix
    ./amd.nix
    ./mullvad.nix
  ];
}
