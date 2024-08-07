name: { pkgs, lib, config, ... } @ inputs: {
  imports = [ (import ../common/home.nix name) ];

  config = lib.mkIf config.enabledUsers.${name}.enable {
  };
}
