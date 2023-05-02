{ pkgs, ... }: {
  home.stateVersion = "22.11";

  home.packages = with pkgs; [ ];

  programs.zsh.shellAliases = {
    s = "sudo nixos-rebuild switch --flake ~/Flake/.#laptop";
  };
}
