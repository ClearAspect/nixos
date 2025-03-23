{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  user = "roanm";
  xdg_configHome = "/home/${user}/.config";
  programs = import ./programs {inherit config pkgs lib inputs;};
  sharedPrograms = import ../shared/programs {inherit config pkgs lib;};
  sharedFiles = import ../shared/files.nix {inherit user config pkgs;};
in {
  imports = [
    ./hyprland.nix
    ./gtk.nix
  ];

  home = {
    enableNixpkgsReleaseCheck = false;
    username = "${user}";
    homeDirectory = "/home/${user}";
    packages = pkgs.callPackage ./packages.nix {};
    file = sharedFiles // import ./files.nix {inherit user config pkgs;};
    stateVersion = "21.05";

    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  # Screen lock
  services = {
    hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        splash_offset = 2.0;

        preload = ["~/Pictures/blue_distortion_1.png"];

        wallpaper = [
          "DP-1,~/Pictures/blue_distortion_1.png"
          "DP-2,~/Pictures/blue_distortion_1.png"
          "HDMI-A-1,~/Pictures/blue_distortion_1.png"
        ];
      };
    };
  };

  programs = {} // programs // sharedPrograms;
}
