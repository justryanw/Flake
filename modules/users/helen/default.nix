name: { pkgs, lib, config, ... } @ inputs: {
  config = lib.mkIf config.modules.users.${name}.enable {
    users.users.${name} = { };
  };
}
