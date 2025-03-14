{
  config,
  pkgs,
  ...
}: let
  user = "roanm";
in {
  imports = [
    # System
    ./users.nix
    ./system.nix
    ./packages.nix
    ../../modules/shared/default.nix

    # Agenix Secrets
    ../../modules/darwin/secrets.nix
  ];

  nix = {
    enable = true;
    package = pkgs.nix;
    settings = {
      trusted-users = ["@admin" "${user}"];
      substituters = ["https://nix-community.cachix.org" "https://cache.nixos.org"];
      trusted-public-keys = ["cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="];
    };

    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 2;
        Minute = 0;
      };
      options = "--delete-older-than 30d";
    };

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
