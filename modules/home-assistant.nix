{ ... }: {
  services.home-assistant = {
    enable = true;
    extraComponents = [
      # Components required to complete the onboarding
      # If getting error "Error occurred loading flow for integration X" then go to this page
      # https://github.com/NixOS/nixpkgs/blob/master/pkgs/servers/home-assistant/component-packages.nix
      # and search for X to get the required component to add here
      "esphome"
      "met"
      "radio_browser"
      "ipp"
      "kef"
      "apple_tv"
      "google_translate"
      "webostv"
      "homekit_controller"
      "hive"
      "transmission"
      "zha"
      "sonarr"
      "radarr"
      "lidarr"
      "jellyfin"
    ];

    config = {
      # Includes dependencies for a basic setup
      # https://www.home-assistant.io/integrations/default_config/
      default_config = { };

      automation = "!include automations.yaml";
      scene = "!include scenes.yaml";
    };
  };
}
