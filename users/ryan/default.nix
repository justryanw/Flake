{ pkgs, ... } @ inputs:
let
  name = "ryan";
in
{
  imports = [ (import ../common name) ];

  users.users.${name} = {
    packages = with pkgs; [
      vscode
      bitwarden-desktop
      vesktop
    ];
  };
}
