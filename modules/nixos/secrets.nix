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
    "/home/${user}/.ssh/id_ed25519"
  ];

  age.secrets."api-Claude" = {
    symlink = true;
    # path = "/home/${user}/.ssh/id_github";
    file = "${secrets}/api-Claude.age";
    # mode = "600";
    # owner = "${user}";
    # group = "wheel";
  };

  age.secrets."api-OpenAI" = {
    symlink = true;
    # path = "/home/${user}/.ssh/id_github";
    file = "${secrets}/api-OpenAI.age";
    # mode = "600";
    # owner = "${user}";
    # group = "wheel";
  };
}
