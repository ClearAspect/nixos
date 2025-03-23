{
  config,
  pkgs,
  lib,
  ...
}: let
  user = "roanm";
  # Define the content of your file as a derivation
  sharedPrograms = import ../shared/programs {inherit config pkgs lib;};
  sharedFiles = import ../shared/files.nix {inherit config pkgs;};
in {
  home = {
    enableNixpkgsReleaseCheck = false;
    username = "${user}";
    packages = pkgs.callPackage ./packages.nix {};
    file = sharedFiles // import ./files.nix {inherit user config pkgs;};
    stateVersion = "24.11";

    sessionVariables = {
      EDITOR = "nvim";
      JAVA_HOME = "${pkgs.openjdk}/lib/openjdk";
    };
    sessionPath = [
      "${config.home.homeDirectory}/.cargo/bin"
      "${config.home.homeDirectory}/.local/bin"
      "${config.home.homeDirectory}/.local/share/nvim/mason/bin"
    ];
  };

  # Home Manager Programs -- Ammend shared program configurations
  programs = {} // sharedPrograms;

  # Marked broken Oct 20, 2022 check later to remove this
  # https://github.com/nix-community/home-manager/issues/3344
  manual.manpages.enable = true;
}
