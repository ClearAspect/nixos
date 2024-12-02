{
  user,
  config,
  pkgs,
  ...
}: let
  xdg_configHome = "${config.users.users.${user}.home}/.config";
  xdg_dataHome = "${config.users.users.${user}.home}/.local/share";
  xdg_stateHome = "${config.users.users.${user}.home}/.local/state";
  Roans-MacBook-Pro = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEwqozRS0wVI+dZj3lUyiRzxaKK3hPKWDcwlMdjI1gz9 roanmason@live.ca";
in {
  ".ssh/id_ed25519.pub" = {
    text = Roans-MacBook-Pro;
  };
}
