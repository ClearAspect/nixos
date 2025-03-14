{
  config,
  pkgs,
  ...
}: let
  user = "roanm";
  keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEwqozRS0wVI+dZj3lUyiRzxaKK3hPKWDcwlMdjI1gz9 roanmason@live.ca"];
in {
  # Users / Me

  users = {
    users = {
      ${user} = {
        home = "/home/roanm";
        createHome = true;
        isNormalUser = true;
        extraGroups = [
          "wheel" # Enable ‘sudo’ for the user.
          "docker"
        ];
        shell = pkgs.fish;
        openssh.authorizedKeys.keys = keys;
      };
      root = {
        openssh.authorizedKeys.keys = keys;
      };
    };
  };
}
