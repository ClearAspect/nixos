{
  config,
  pkgs,
  ...
}: let
  name = "ClearAspect";
  user = "roanm";
  email = "roanmason@live.ca";
in {
  git = {
    enable = true;
    # ignores = ["*.swp"];
    userName = name;
    userEmail = email;
    signing.key = "49E644A14A3E533C";
    lfs.enable = true;

    extraConfig = {
      commit.gpgSign = true;
      init.defaultBranch = "master";
      core = {
        editor = "nvim";
        # autocrlf = "input";
      };
      # credential.credentialStore = "gpg";
      # credential.helper = "manager";
      pull.rebase = "false";
    };
  };

  gh = {
    enable = true;
  };
}
