{ pkgs, ... } @ inputs:
let
  common = import ../common inputs;
in
common // {
  packages = common.packages ++ (with pkgs; [
    vscode
    bitwarden-desktop
    vesktop
  ]);
}
