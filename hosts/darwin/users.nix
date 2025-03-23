{
  config,
  pkgs,
  ...
}: let
  user = "roanm";
in {
  # Users / Me
  users = {
    users.${user} = {
      name = "${user}";
      home = "/Users/${user}";
      isHidden = false;
      shell = pkgs.fish;
    };
  };
}
