name: { pkgs, lib, config, ... }: {
  config = lib.mkIf config.enabledUsers.${name}.enable {
    home-manager.users.${name} = { ... }: {
      home.stateVersion = "23.05";

      programs = {
        starship.enable = true;

        zsh.enable = true;
      };
    };
  };
}
