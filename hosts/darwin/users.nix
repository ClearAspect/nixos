{
  config,
  pkgs,
  lib,
  ...
}: let
  user = "roanm";
  sharedHome = import ../../modules/shared/home-manager.nix {inherit config pkgs lib;};
  sharedFiles = import ../../modules/shared/files.nix {inherit config pkgs;};
  additionalFiles = import ../../modules/darwin/files.nix {inherit user config pkgs;};
in {
  # Users / Me
  users = {
    users.${user} = {
      name = "${user}";
      home = "/Users/${user}";
      isHidden = false;
      shell = pkgs.fish;
    };
  };

  # Home Manager for each user
  home-manager = {
    useGlobalPkgs = true;
    users = {
      ${user} = {
        config,
        pkgs,
        ...
      }: {
        home = {
          enableNixpkgsReleaseCheck = false;
          username = "${user}";
          packages = pkgs.callPackage ../../modules/darwin/packages.nix {};
          file = sharedFiles // additionalFiles;
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
      };
    };
  };
}
