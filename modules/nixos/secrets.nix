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
    };
  };
}
