{
  description = "My system config";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
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
          modules = [
            ./hosts/vm
            ./shared.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ryan = { imports = [ (./home/ryan.nix) ] ++ [ (./hosts/vm/home.nix) ]; };
              home-manager.users.root = { imports = [ ./home/root.nix ]; };
            }
          ];
        };

        laptop = lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/laptop
            ./shared.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ryan = { imports = [ (./home/ryan.nix) ] ++ [ (./hosts/laptop/home.nix) ]; };
              home-manager.users.root = { imports = [ ./home/root.nix ]; };
            }
          ];
        };

      };
    };
}
