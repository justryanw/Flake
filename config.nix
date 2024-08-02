{ pkgs, ... } @ inputs: 
let
    user = "ryan";
in
{
    imports = [
        ./hardware-configuration.nix
    ];

    nix.settings = {
        trusted-users = [ "root" "@wheel" ];
        experimental-features = [ "nix-command" "flakes" ];
    };

    nixpkgs.config.allowUnfree = true;

    time.timeZone = "Europe/London";
    i18n.defaultLocale = "en_GB.UTF-8";

    services = {
        xserver = {
            enable = true;
            displayManager.gdm.enable = true;
            desktopManager.gnome.enable = true;
        };
    };

    programs = {
        zsh.enable = true;
        nh.enable = true;

        nix-ld = {
            enable = true;
            package = pkgs.nix-ld-rs;
        };
    };

    users.users.${user}.shell = pkgs.zsh;

    environment = {
        pathsToLink = [ "/share/zsh" ];
    
        systemPackages = with pkgs; [
        nixd
        nixpkgs-fmt
        ];
    };
}