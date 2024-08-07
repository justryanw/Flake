name: { pkgs, ... } @ inputs: {
  imports = [ (import ../common name) ];

  users.users.${name} = {
    extraGroups = [ "wheel" ];

    packages = with pkgs; [
      vscode
      bitwarden-desktop
      vesktop
    ];
  };
}
