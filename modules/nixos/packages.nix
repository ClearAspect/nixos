{pkgs}:
with pkgs; let
  shared-packages = import ../shared/packages.nix {inherit pkgs;};
in
  shared-packages
  ++ [
    # ┏━━━━━━━━━━━━━━━━━━━┓
    # ┃   Wayland Tools   ┃
    # ┗━━━━━━━━━━━━━━━━━━━┛
    waybar
    gtk-layer-shell
    hyprpaper
    wofi
    wl-clipboard
    xdg-desktop-portal-hyprland

    # ┏━━━━━━━━━━━┓
    # ┃   Games   ┃
    # ┗━━━━━━━━━━━┛
    steam
    heroic
    xboxdrv

    # ┏━━━━━━━━━━━━━━━━━━┓
    # ┃   Applications   ┃
    # ┗━━━━━━━━━━━━━━━━━━┛
    firefox
    vesktop
    discord-canary
    eclipses.eclipse-java
    atlauncher

    # ┏━━━━━━━━━━━━━━━━━━┓
    # ┃   System Tools   ┃
    # ┗━━━━━━━━━━━━━━━━━━┛
    nautilus
    loupe
    gnome-font-viewer
    pavucontrol
    dconf-editor
    nwg-look
    wlogout

    # ┏━━━━━━━━━━━━━━━━━━┓
    # ┃   System Utils   ┃
    # ┗━━━━━━━━━━━━━━━━━━┛
    ntfs3g
    colord
    xiccd
    gcc
    pinentry-curses

    # ┏━━━━━━━━━━━━━━━━━━┓
    # ┃   Theming & UI   ┃
    # ┗━━━━━━━━━━━━━━━━━━┛
    apple-cursor
    whitesur-icon-theme
    sf-pro
  ]
