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
      "/home/${user}/.ssh/id_ed25519"
    ];

    secrets = {
      "github-ssh-key" = {
        symlink = false;
        path = "/home/${user}/.ssh/id_github";
        file = "${secrets}/github-ssh-key-nixos.age";
        mode = "600";
        owner = "${user}";
        group = "wheel";
      };
    };
  };
}
