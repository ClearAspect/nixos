{
  config,
  pkgs,
  ...
}: {
  keychain = {
    # Shit broken
    enable = true;
    enableFishIntegration = true;
    agents = ["gpg"];
    keys = ["id_ed25519"]; # MUST match the filename in ~/.ssh/
    extraFlags = ["--quiet" "--nogui" "--noask"];
  };
}
