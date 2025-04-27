{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";

    nixpkgs-unfree = {
      url = "github:numtide/nixpkgs-unfree/nixos-unstable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    polymc = {
      url = "github:polymc/polymc";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    jovian-nixos.url = "github:Jovian-Experiments/Jovian-NixOS";
  };

  outputs = {
    self,
    nixpkgs,
    determinate,
    home-manager,
    disko,
    jovian-nixos,
    ...
  } @ inputs: let
    hosts = [
      "desktop"
      "laptop"
      "usb"
      "server"
      "pavilion"
      "jupiter"
    ];
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system self;};

    createSystem = host:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
        };
        modules = [
          home-manager.nixosModules.default
          disko.nixosModules.default
          jovian-nixos.nixosModules.default
          determinate.nixosModules.default
          host
        ];
      };
  in {
    nixosConfigurations = builtins.listToAttrs (
      map (name: {
        inherit name;
        value = createSystem ./hosts/${name};
      })
      hosts
    );

    packages.${system} = {
      write-usb = pkgs.writeShellScriptBin "write-usb" ''
        # write-usb /dev/sdb
        sudo ${disko}/disko-install --flake ${self}#usb --disk usb $1
      '';
      run-usb = pkgs.writeShellScriptBin "run-usb" ''
        # run-usb /dev/sdb
        sudo ${pkgs.qemu_kvm}/bin/qemu-kvm -enable-kvm \
          -m 8G \
          -smp cores=4 \
          -bios "${pkgs.OVMF.fd}/FV/OVMF.fd" \
          -hda $1
      '';
      install-nixos = pkgs.writeShellScriptBin "install-nixos" ''
        # install-nixos hostname /dev/sda
        sudo ${disko}/disko-install --flake ${self}#$1 --disk $1 $2
      '';
      check-uefi = pkgs.writeShellScriptBin "check-uefi" ''
        [ -d /sys/firmware/efi ] && echo "UEFI Boot Detected" || echo "Legacy BIOS Boot Detected"
      '';
      ygg-ip = pkgs.writeScriptBin "ygg-ip" "yggdrasilctl getself | grep 'IPv6 address' | awk '{print $NF}'";
      qr = pkgs.writeScriptBin "qr" "${pkgs.qrencode}/bin/qrencode -t ANSI";
      allSystems = let
        systems = builtins.attrValues self.nixosConfigurations;
      in
        nixpkgs.legacyPackages."x86_64-linux".symlinkJoin {
          name = "all-systems";
          paths = map (sys: sys.config.system.build.toplevel) systems;
        };
    };

    devShells.${system}.default = pkgs.mkShell {
      buildInputs = with self.packages.${system}; [
        write-usb
        run-usb
        check-uefi
        install-nixos
        ygg-ip
        qr
      ];
    };
  };
}
