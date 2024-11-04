{pkgs}:
with pkgs; let
  shared-packages = import ../shared/packages.nix {inherit pkgs;};
in
  shared-packages
  ++ [
    hyprpanel
    wofi
    kitty

    firefox
    vesktop
    rstudio
    eclipses.eclipse-java

    nautilus
    gnome-font-viewer
    pavucontrol
    dconf-editor
    nwg-look
    wlogout

    apple-cursor
    whitesur-gtk-theme
    whitesur-icon-theme

    xdg-desktop-portal-hyprland
    wl-clipboard
  ]
