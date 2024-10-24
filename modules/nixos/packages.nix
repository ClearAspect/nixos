{pkgs}:
with pkgs; let
  shared-packages = import ../shared/packages.nix {inherit pkgs;};
in
  shared-packages
  ++ [
    waybar
    wofi
    xdg-desktop-portal-hyprland
    kitty
    ghostty.packages.x86_64-linux.default
    firefox
    vesktop

    nautilus
    gnome-font-viewer
    pavucontrol
    dconf-editor
    nwg-look

    apple-cursor
    whitesur-gtk-theme
    whitesur-icon-theme
  ]
