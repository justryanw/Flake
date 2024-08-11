name: { pkgs, lib, config, ... } @ inputs:
let
  cfg = config.modules.users.${name};
in
{
  imports = [ (import ./home.nix name) ];

  options = {
    modules.users.${name} = {
      enable = lib.mkEnableOption "Enables user";
      defaultConfig.enable = lib.mkEnableOption "Enables default config for user";
    };
  };

  config = lib.mkIf (cfg.enable && cfg.defaultConfig.enable) {
    users.users.${name} = {
      description = (lib.strings.toUpper (builtins.substring 0 1 name)) + (builtins.substring 1 (-1) name);
      isNormalUser = true;
      extraGroups = [ "networkmanager" "dialout" ];
      shell = pkgs.zsh;
      packages = lib.mkIf config.modules.graphics.enable (with pkgs; [
        firefox
        libreoffice
      ]);

      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG2+1HkbVk10Wt5I5l6iPkXcAUCLQ8EQ4qs9MYIXXlqK ryan@Desktop"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINDGUsv2xnB04Jh+M15As1jJs/MvtnAqeJ5FsSaXGv3S ryanjwalker2001@gmail.com"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH/tpdZr5X8NgBldgtviMMgNOUWDRckjZNYIhIk/CX/h ryan@Laptop"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDbYyLHLWRdv9djFcSVIKmUFVtV35Ztj4t8iVLL+A/Z+ kevin@nixos"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICWIiPRXGHVkhx1O/YDNOJfFQADhld2CxQKRKCnW1Fhv ryan@NixVM"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBl7qYlcDcv/3dkMxX3MkKcTdfxCdEKuGUxbEzfuAZ9F ryan@Pavilion"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPGg4nR3v4p0/0/8hKsIqRy2YGFAvMlGuDXCDGuA++FR nix-on-droid@localhost"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJbOCsQ0JHfnFgOanl56w/y1o3dhHtOnkgqW8aTBxWuc ryan.walker@LAP00396"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKHT6zqmuClgoKRyhqJWvImrJU0nnS8rOIGgGB9RE0ta deck@steamdeck"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPJk8jNtogRebXhF3m3iA2A7KsYNT7DPdCfpbP6Y09Zq ryan@server"
      ];
    };
  };
}
