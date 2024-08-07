name: { pkgs, lib, config, ... }: {
  options = {
    enabledUsers.${name}.enable = lib.mkEnableOption "Toggles user";
  };

  config = lib.mkIf config.enabledUsers.${name}.enable {
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
