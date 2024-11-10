{
  config,
  pkgs,
  agenix,
  secrets,
  ...
}: let
  user = "roanm";
in {
  age.identityPaths = [
    "/Users/${user}/.ssh/id_ed25519"
  ];

  age.secrets."github-ssh-key" = {
    symlink = true;
    path = "/Users/${user}/.ssh/id_ed25519";
    file = "${secrets}/github-ssh-key-macbook.age";
    mode = "600";
    owner = "${user}";
    group = "wheel";
  };
}
