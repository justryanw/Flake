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

  outputs = { self, nixpkgs, home-manager, disko, ... } @ inputs:
    let
      hosts = [ "desktop" "laptop" "usb" "server" ];
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system self; };

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
        write-usb = pkgs.writeShellScriptBin "write-usb" ''
          sudo ${disko}/disko-install --flake ${self}#usb --disk usb $1
        '';
        run-usb = pkgs.writeShellScriptBin "run-usb" ''
          sudo ${pkgs.qemu_kvm}/bin/qemu-kvm -enable-kvm \
            -m 8G \
            -smp cores=4 \
            -bios "${pkgs.OVMF.fd}/FV/OVMF.fd" \
            -hda $1
        '';
        check-uefi = pkgs.writeShellScriptBin "check-uefi" ''
          [ -d /sys/firmware/efi ] && echo "UEFI Boot Detected" || echo "Legacy BIOS Boot Detected"
        '';
        install-nixos = pkgs.writeShellScriptBin "install-nixos" ''
          sudo ${disko}/disko-install --flake ${self}#$1 --disk $1 $2
        '';
      };

      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with self.packages.${system}; [
          write-usb
          run-usb
          check-uefi
          install-nixos
        ];
      };
    };
}
