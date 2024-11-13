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

  # age.secrets."github-ssh-key-macbook" = {
  #   symlink = true;
  #   path = "/Users/${user}/.ssh/id_github";
  #   file = "${secrets}/github-ssh-key-macbook.age";
  #   mode = "600";
  #   owner = "${user}";
  #   group = "wheel";
  # };
}
