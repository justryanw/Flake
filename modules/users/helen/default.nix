name: { pkgs, lib, config, ... } @ inputs: {
  config = lib.mkIf config.enabledUsers.${name}.enable {
    users.users.${name} = { };
  };
}
