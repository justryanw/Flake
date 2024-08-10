name: { lib, config, ... } @ inputs: {
  imports = [ (import ../ryan name) (import ./home.nix name)];

   config = lib.mkIf config.modules.users.${name}.enable {

   };
}
