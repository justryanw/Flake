name: { pkgs, lib, config, ... } @ inputs:
let
  cfg = config.modules.users.${name};
in
{
  imports = [ (import ./home.nix name) ];

  options = {
    modules.users.${name} = {
      enable = lib.mkEnableOption "Enables user";
      defaultConfig.enable = lib.mkEnableOption "Enables default config for user";
    };
  };

  config = lib.mkIf (cfg.enable && cfg.defaultConfig.enable) {
    users.users.${name} = {
      description = (lib.strings.toUpper (builtins.substring 0 1 name)) + (builtins.substring 1 (-1) name);
      isNormalUser = true;
      extraGroups = [ "networkmanager" "dialout" ];
      shell = pkgs.zsh;
      packages = with pkgs; [
        firefox
      ];
    };
  };
}
