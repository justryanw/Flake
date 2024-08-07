{ pkgs, ... }: {
  isNormalUser = true;
  extraGroups = [ "wheel" "networkmanager" "dialout" ];
  shell = pkgs.zsh;
  packages = with pkgs; [
    firefox
  ];
}
