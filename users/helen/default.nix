name: { pkgs, lib, config, ... } @ inputs: {
  imports = [ (import ../common name) ];

  config = lib.mkIf config.enabledUsers.${name}.enable {
    users.users.${name} = { };
  };
}
