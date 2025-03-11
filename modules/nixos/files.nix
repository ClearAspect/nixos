{user, ...}: let
  home = builtins.getEnv "HOME";
  xdg_configHome = "${home}/.config";
  xdg_dataHome = "${home}/.local/share";
  xdg_stateHome = "${home}/.local/state";
in {
  ".config/waybar".source = ./config/waybar;
  ".config/wlogout".source = ./config/wlogout;
}
