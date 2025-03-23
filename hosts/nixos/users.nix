{
  config,
  pkgs,
  ...
}: let
  user = "roanm";
in {
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
      };
    };
  };
}
