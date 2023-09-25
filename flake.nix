{
  description = "My system config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-software-center.url = "github:vlinkz/nix-software-center";
  };

  outputs = inputs @ { self, nixpkgs, home-manager, nix-software-center }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {

        vm = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs system;
            state = "22.11";
          };
          modules = [
            ./hosts/vm
            ./shared.nix
            ./modules/bootloader/bios.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                state = "22.11";
              };
              home-manager.users.ryan = { imports = [ (./home/shared.nix) ] ++ [ (./home/ryan.nix) ] ++ [ (./hosts/vm/home.nix) ]; };
              home-manager.users.root = { imports = [ (./home/shared.nix) ] ++ [ ./home/root.nix ]; };
            }
          ];
        };

        laptop = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs system;
            state = "22.11";
          };
          modules = [
            ./hosts/laptop
            ./shared.nix
            ./modules/bootloader/efi.nix
            ./modules/monero.nix
            # ./modules/xmrig.nix
            #./modules/rtl-sdr.nix
            # ./containers/vpn.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                state = "22.11";
              };
              home-manager.users.ryan = { imports = [ (./home/shared.nix) ] ++ [ (./home/ryan.nix) ] ++ [ (./hosts/laptop/home.nix) ]; };
              home-manager.users.root = { imports = [ (./home/shared.nix) ] ++ [ ./home/root.nix ]; };
            }
          ];
        };

        desktop = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs system;
            state = "23.05";
          };
          modules = [
            ./hosts/desktop
            ./shared.nix
            ./modules/bootloader/efi.nix
            # ./containers/vpn.nix
            ./modules/virt.nix
            ./modules/wooting.nix
            # ./modules/monero.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                state = "23.05";
              };
              home-manager.users.ryan = { imports = [ (./home/shared.nix) ] ++ [ (./home/ryan.nix) ] ++ [ (./hosts/desktop/home.nix) ]; };
              home-manager.users.root = { imports = [ (./home/shared.nix) ] ++ [ (./home/root.nix) ]; };
            }
          ];
        };


        kevin = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs system;
            state = "23.05";
          };
          modules = [
            ./hosts/kevin
            ./shared.nix
            ./modules/bootloader/bios.nix
            # ./containers/vpn.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                state = "23.05";
              };
              home-manager.users.kevin = { imports = [ (./home/shared.nix) ] ++ [ (./home/kevin.nix) ] ++ [ (./hosts/kevin/home.nix) ]; };
              home-manager.users.root = { imports = [ (./home/shared.nix) ] ++ [ (./home/root.nix) ]; };
            }
          ];
        };

      };
    };
}
