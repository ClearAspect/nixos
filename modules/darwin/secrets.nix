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
    };
  };
}
