{pkgs}:
with pkgs; let
  shared-packages = import ../shared/packages.nix {inherit pkgs;};
in
  shared-packages
  ++ [
    # ┏━━━━━━━━━━━━━━━━━━━┓
    # ┃   Wayland Tools   ┃
    # ┗━━━━━━━━━━━━━━━━━━━┛
    waypaper
    gtk-layer-shell
    wl-clipboard
    xdg-desktop-portal-hyprland

    # ┏━━━━━━━━━━━┓
    # ┃   Games   ┃
    # ┗━━━━━━━━━━━┛
    steam
    heroic

    # ┏━━━━━━━━━━━━━━━━━━┓
    # ┃   Applications   ┃
    # ┗━━━━━━━━━━━━━━━━━━┛
    firefox
    vesktop
    discord-canary
    eclipses.eclipse-java
    atlauncher
    prismlauncher

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
