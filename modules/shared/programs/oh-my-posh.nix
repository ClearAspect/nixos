{
  config,
  pkgs,
  ...
}: {
  oh-my-posh = {
    enable = true;
    settings = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile ../../../files/oh-my-posh/omp.json));
  };
}
