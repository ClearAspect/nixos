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
  ];

  # ┏━━━━━━━━━┓
  # ┃   Nix   ┃
  # ┗━━━━━━━━━┛
  nix = {
    nixPath = ["nixos-config=/home/${user}/.local/share/src/nixos-config:/etc/nixos"];
    settings = {
      allowed-users = ["${user}"];
      trusted-users = ["@admin" "${user}"];
      substituters = ["https://nix-community.cachix.org" "https://cache.nixos.org"];
      trusted-public-keys = ["cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="];
    };

    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  system.stateVersion = "21.05"; # Don't change this
}
