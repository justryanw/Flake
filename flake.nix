{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    };

    outputs = { nixpkgs, ... } @ inputs: {
        nixosConfigurations = {
            desktop = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = { inherit inputs; };
                modules = [
                    ./configuration.nix
                ];
            };
        };
    };
}