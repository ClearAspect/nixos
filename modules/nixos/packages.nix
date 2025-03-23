{pkgs}:
with pkgs; let
  shared-packages = import ../shared/packages.nix {inherit pkgs;};
in
  shared-packages
  ++ [
    steam
    heroic
    xboxdrv

    # Hyprland Wayland
    waybar
    gtk-layer-shell
    hyprpaper
    wofi
    wl-clipboard

    firefox
    vesktop
    discord-canary
    eclipses.eclipse-java

    nautilus
    loupe
    gnome-font-viewer
    pavucontrol
    dconf-editor
    nwg-look
    wlogout

    apple-cursor
    whitesur-icon-theme

    xdg-desktop-portal-hyprland

    # Tools
    ntfs3g
    colord
    xiccd

    # Fonts
    sf-pro

    # Extras
    gcc

    pinentry-curses
  ]
