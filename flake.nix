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
      hosts = [ "desktop" "laptop" "iso" ];

      createSystem = host: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
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
    };
}
