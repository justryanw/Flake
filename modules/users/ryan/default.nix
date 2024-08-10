name: { pkgs, lib, config, ... } @ inputs: {
  imports = [ (import ./home.nix name)];

  config = lib.mkIf config.modules.users.${name}.enable {
    users.users.${name} = {
      extraGroups = [ "wheel" ];
      initialHashedPassword = lib.mkDefault "$y$j9T$/0D7TzdJ47wVaY77j8gnJ.$RKHvm/DQTTD8xCdx1ZRhhj9fMuiP5kocHXRmwBBPPR1";

      packages = lib.mkIf config.modules.graphics.enable (with pkgs; [
        bitwarden-desktop
        vesktop
      ]);
    };
  };
}
