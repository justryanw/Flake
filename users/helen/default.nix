{ pkgs, ... } @ inputs:
let
  name = "helen";
in
{
  imports = [ (import ../common name) ];

  users.users.${name} = { };
}
