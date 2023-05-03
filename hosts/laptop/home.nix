{ pkgs, state, ... }: {
  home.stateVersion = state;

  home.packages = with pkgs; [ ];

  programs.zsh.shellAliases = {
    s = "sudo nixos-rebuild switch --flake ~/Flake/.#laptop";
  };
}
