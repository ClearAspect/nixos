{user, ...}: let
  home = builtins.getEnv "HOME";
  xdg_configHome = "${home}/.config";
  xdg_dataHome = "${home}/.local/share";
  xdg_stateHome = "${home}/.local/state";
in {
  ".config/ghostty".source = ../../files/ghostty-linux;
  ".config/waybar".source = ../../files/waybar;
  ".config/wlogout".source = ../../files/wlogout;
}
