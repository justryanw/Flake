name: { pkgs, lib, ... }: {
  users.users.${name} = {
    description = (lib.strings.toUpper (builtins.substring 0 1 name)) + (builtins.substring 1 (-1) name);
    isNormalUser = true;
    extraGroups = [ "networkmanager" "dialout" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
    ];
  };
}
