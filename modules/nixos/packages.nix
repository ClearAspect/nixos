{pkgs}:
with pkgs; let
  shared-packages = import ../shared/packages.nix {inherit pkgs;};
in
  shared-packages
  ++ [
    steam
    hyprpanel
    wofi
    # kitty

    firefox
    vesktop
    discord-canary
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

    # Tools
    ntfs3g
    colord
    xiccd

    # Fonts
    sf-pro
  ]
