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

  # age.secrets."api-Claude" = {
  #   symlink = true;
  #   # path = "/run/agenix/api-Claude";
  #   file = "${secrets}/api-Claude.age";
  #   # mode = "600";
  #   # owner = "${user}";
  #   # group = "wheel";
  # };

  # age.secrets."api-OpenAI" = {
  #   symlink = true;
  #   # path = "/run/agenix/api-OpenAI";
  #   file = "${secrets}/api-OpenAI.age";
  #   # mode = "600";
  #   # owner = "${user}";
  #   # group = "wheel";
  # };
}
