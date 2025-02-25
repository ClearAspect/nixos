{user, ...}: let
  home = builtins.getEnv "HOME";
  xdg_configHome = "${home}/.config";
  xdg_dataHome = "${home}/.local/share";
  xdg_stateHome = "${home}/.local/state";
in {
  # "${xdg_configHome}/rofi/colors.rasi".text = builtins.readFile ./config/rofi/colors.rasi;
  # "${xdg_configHome}/rofi/confirm.rasi".text = builtins.readFile ./config/rofi/confirm.rasi;
  # "${xdg_configHome}/rofi/launcher.rasi".text = builtins.readFile ./config/rofi/launcher.rasi;
  # "${xdg_configHome}/rofi/message.rasi".text = builtins.readFile ./config/rofi/message.rasi;
  # "${xdg_configHome}/rofi/networkmenu.rasi".text = builtins.readFile ./config/rofi/networkmenu.rasi;
  # "${xdg_configHome}/rofi/powermenu.rasi".text = builtins.readFile ./config/rofi/powermenu.rasi;
  # "${xdg_configHome}/rofi/styles.rasi".text = builtins.readFile ./config/rofi/styles.rasi;

  ".config/waybar".source = ./config/waybar;
  ".config/wlogout".source = ./config/wlogout;
}
