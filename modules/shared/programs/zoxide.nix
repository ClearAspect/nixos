{
  config,
  pkgs,
  ...
}: {
  zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}
