name: { pkgs, ... }: {
  users.users.${name} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "dialout" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
    ];
  };
}
