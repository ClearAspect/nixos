{
  config,
  pkgs,
  agenix,
  secrets,
  user,
  ...
}: let
  user = "roanm";
in {
  age = {
    identityPaths = [
      "/home/${user}/.ssh/id_ed25519"
    ];

    secrets = {
      "github-ssh-key" = {
        symlink = false;
        path = "/home/${user}/.ssh/id_ed25519";
        file = "${secrets}/github-ssh-key-nixos.age";
        mode = "600";
        owner = "${user}";
        group = "wheel";
      };
    };
  };
}
