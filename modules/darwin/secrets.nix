{
  config,
  pkgs,
  agenix,
  secrets,
  ...
}: let
  user = "dustin";
in {
  age = {
    identityPaths = [
      "/Users/${user}/.ssh/id_ed25519"
    ];

    secrets = {
      "github-ssh-key" = {
        symlink = false;
        path = "/Users/${user}/.ssh/id_github";
        file = "${secrets}/github-ssh-key-macbook.age";
        mode = "600";
        owner = "${user}";
        group = "wheel";
      };
    };
  };
}
