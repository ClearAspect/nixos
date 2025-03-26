{
  config,
  pkgs,
  ...
}: {
  networking = {
    hostName = "NixosDesktop"; # Define your hostname.
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
    # useDHCP = lib.mkDefault true;
    # interfaces."%INTERFACE%".useDHCP = true;
  };

  services.openssh.enable = true;
}
