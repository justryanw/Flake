name: { pkgs, lib, config, ... } @ inputs: {
  imports = [ (import ./home.nix name)];

  config = lib.mkIf config.modules.users.${name}.enable {
    users.users.${name} = {
      extraGroups = [ "wheel" ];

      packages = lib.mkIf config.modules.graphics.enable (with pkgs; [
        bitwarden-desktop
        vesktop
      ]);
    };
  };
}
