name: { pkgs, lib, config, ... } @ inputs: {
  imports = [ (import ./home.nix name)];

  config = lib.mkIf config.enabledUsers.${name}.enable {
    users.users.${name} = {
      extraGroups = [ "wheel" ];

      packages = with pkgs; [
        vscode
        bitwarden-desktop
        vesktop
      ];
    };
  };
}