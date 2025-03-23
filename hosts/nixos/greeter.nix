{
  config,
  pkgs,
  ...
}: let
  user = "roanm";
in {
  # Use tuigreet
  services.greetd = {
    enable = true;
    package = pkgs.greetd.tuigreet;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --user-menu --remember-session --cmd Hyprland";
        user = "${user}";
      };
    };
  };
}
