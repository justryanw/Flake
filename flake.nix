{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... } @ inputs:
    let
      hosts = [ "desktop" "laptop" "iso" "server" ];
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      createSystem = host: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.nixosModules.default
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
      };
    };
}
