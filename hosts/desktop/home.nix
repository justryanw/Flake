{ pkgs, ... }: {
  home.stateVersion = "23.05";

  home.packages = with pkgs; [ ];

  programs.zsh.shellAliases = {
    s = "sudo nixos-rebuild switch --flake ~/Flake/.#desktop";
  };
}
