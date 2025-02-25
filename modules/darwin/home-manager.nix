{
  config,
  pkgs,
  lib,
  home-manager,
  ...
}: let
  user = "roanm";
  # Define the content of your file as a derivation
  sharedHome = import ../shared/home-manager.nix {inherit config pkgs lib;};
  sharedFiles = import ../shared/files.nix {inherit config pkgs;};
  # sharedFiles = import ../shared/files.nix {inherit config pkgs;};
  # additionalFiles = import ./files.nix {inherit user config pkgs;};
in {
  # imports = [
  #   ./dock
  # ];

  # # Enable home-manager
  # home-manager = {
  #   useGlobalPkgs = true;
  #   users.${user} = {
  #     pkgs,
  #     config,
  #     lib,
  #     ...
  #   }: {
  #     # imports = [
  #     #   catppuccin.homeManagerModules.catppuccin
  #     # ];

  home = {
    enableNixpkgsReleaseCheck = false;
    username = "${user}";
    packages = pkgs.callPackage ./packages.nix {};
    file = sharedFiles // import ./files.nix {inherit user config pkgs;};
    stateVersion = "23.11";

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
  programs = {} // sharedHome;

  # Marked broken Oct 20, 2022 check later to remove this
  # https://github.com/nix-community/home-manager/issues/3344
  manual.manpages.enable = true;
}
