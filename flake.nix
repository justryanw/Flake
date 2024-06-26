{
  description = "My system config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-software-center.url = "github:snowfallorg/nix-software-center";

    valheim-server = {
      url = "github:aidalgol/valheim-server-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, valheim-server, ... } @ inputs:
    let
      system = "x86_64-linux";
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
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs.state = "22.11";
                users = {
                  ryan.imports = [ ./home/shared.nix ./home/ryan.nix ./hosts/vm/home.nix ];
                  root.imports = [ ./home/shared.nix ./home/root.nix ];
                };
              };
            }
          ];
        };

        laptop = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs system;
            state = "22.11";
            interface = "wlp2s0";
          };
          modules = [
            ./hosts/laptop
            ./shared.nix
            ./modules/bootloader/efi.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs.state = "22.11";
                users = {
                  root.imports = [ ./home/shared.nix ./home/root.nix ];
                  ryan.imports = [ ./home/shared.nix ./home/ryan.nix ./hosts/laptop/home.nix ];
                };
              };
            }
          ];
        };

        pavilion = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs system;
            state = "22.11";
            interface = "wlo1";
          };
          modules = [
            ./hosts/pavilion
            ./shared.nix
            ./modules/bootloader/efi.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs.state = "22.11";
                users = {
                  root.imports = [ ./home/shared.nix ./home/root.nix ];
                  ryan.imports = [ ./home/shared.nix ./home/ryan.nix ./hosts/pavilion/home.nix ];
                };
              };
            }
          ];
        };

        desktop = lib.nixosSystem {
          specialArgs = {
            inherit inputs system;
            state = "23.05";
            interface = "eno2";
          };
          modules = [
            ./hosts/desktop
            ./shared.nix
            ./containers/vpn.nix
            ./modules/bootloader/efi.nix
            ./modules/wooting.nix
            ./modules/monero.nix
            ./modules/xmrig.nix
            ./modules/home-assistant.nix
            ./modules/jellyfin.nix
            home-manager.nixosModules.home-manager
            valheim-server.nixosModules.default
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs.state = "23.05";
                users = {
                  root.imports = [ ./home/shared.nix ./home/root.nix ];
                  ryan.imports = [ ./home/shared.nix ./home/ryan.nix ./hosts/desktop/home.nix ];
                };
              };
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
            ./containers/vpn.nix
            ./modules/bootloader/bios.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs.state = "23.05";
                users = {
                  root.imports = [ ./home/shared.nix ./home/root.nix ];
                  ryan.imports = [ ./home/shared.nix ./home/kevin.nix ./hosts/kevin/home.nix ];
                };
              };
            }
          ];
        };

      };
    };
}
