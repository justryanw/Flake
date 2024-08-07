name: { pkgs, lib, config, ... } @ inputs: {
  imports = [ (import ./home.nix name)];

  options = {
    enabledUsers.${name} = {
      enable = lib.mkEnableOption "Enables user";
      defaultConfig.enable = lib.mkEnableOption "Enables default config for user";
    };
  };

  config = lib.mkIf config.enabledUsers.${name}.enable (lib.mkIf config.enabledUsers.${name}.defaultConfig.enable {
    users.users.${name} = {
      description = (lib.strings.toUpper (builtins.substring 0 1 name)) + (builtins.substring 1 (-1) name);
      isNormalUser = true;
      extraGroups = [ "networkmanager" "dialout" ];
      shell = pkgs.zsh;
      packages = with pkgs; [
        firefox
      ];
    };
  });
}
