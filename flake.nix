{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, disko, ... } @ inputs:
    let
      hosts = [ "desktop" "laptop" "usb" "server" ];
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      createSystem = host: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.nixosModules.default
          disko.nixosModules.default
          host
        ];
      };
    in
    {
      nixosConfigurations = builtins.listToAttrs
        (map
          (name: {
            inherit name;
            value = createSystem ./hosts/${name};
          })
          hosts);

      packages.${system} = {
        gen-iso = pkgs.writeShellScriptBin "gen-iso" ''
          ${pkgs.nixos-generators}/bin/nixos-generate --format iso --flake .#iso -o result
        '';
        run-usb = pkgs.writeShellScriptBin "gen-iso" ''
          OVMF=$(nix build nixpkgs#OVMF.fd --no-link --print-out-paths)
          VARS_FILE="$HOME/OVMF_VARS.fd"

          # Check if VARS_FILE exists, if not, create it
          if [ ! -f "$VARS_FILE" ]; then
            cp "$OVMF/FV/OVMF_VARS.fd" "$VARS_FILE"
          fi

          sudo ${pkgs.qemu_kvm}/bin/qemu-kvm -enable-kvm \
            -m 4G \
            -smp cores=4 \
            -bios "$OVMF/FV/OVMF.fd" \
            -drive if=pflash,format=raw,readonly=on,file="$OVMF/FV/OVMF_CODE.fd" \
            -drive if=pflash,format=raw,file="$VARS_FILE" \
            -drive file=/dev/sda,format=raw,if=none,id=nvm \
            -usb \
            -device usb-ehci,id=ehci \
            -device usb-storage,bus=ehci.0,drive=usbstick \
            -drive if=none,id=usbstick,file=/dev/sda,format=raw \
            -net none \
            -debugcon file:debug.log -global isa-debugcon.iobase=0x402 \
            -monitor stdio
        '';
        check-uefi = pkgs.writeShellScriptBin "check-uefi" ''
          [ -d /sys/firmware/efi ] && echo UEFI || echo BIOS
        '';
      };
    };
}
