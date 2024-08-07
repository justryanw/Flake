name: { pkgs, ... } @ inputs: {
  imports = [ (import ../common name) ];

  users.users.${name} = { };
}
