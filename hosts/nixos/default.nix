{
  config,
  pkgs,
  ...
}: let
  user = "roanm";
in {
  imports =
    [
      ./filesystem.nix
      ./bootloader.nix
      ./greeter.nix
      ./users.nix
      ./security.nix
      ./nvidia.nix
      ./audio.nix
      ./networking.nix # Include only if you have network-specific settings
      ./packages.nix
    ]
    ++ [(import ../../modules/shared)]
    ++ [(import ../../modules/nixos/secrets.nix)];

  # Turn on flag for proprietary software
  nix = {
    nixPath = ["nixos-config=/home/${user}/.local/share/src/nixos-config:/etc/nixos"];
    settings = {
      allowed-users = ["${user}"];
      trusted-users = ["@admin" "${user}"];
      substituters = ["https://nix-community.cachix.org" "https://cache.nixos.org"];
      trusted-public-keys = ["cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="];
    };

    package = pkgs.nix;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  services.xserver.enable = true;

  # Enable CUPS to print documents
  services.printing = {
    enable = true;
    drivers = [pkgs.brlaser]; # Brother printer driver
  };

  services.gvfs.enable = true; # Mount, trash, and other file system services
  services.tumbler.enable = true; # Thumbnail support for images

  # Time Zone
  time = {
    hardwareClockInLocalTime = true;
    timeZone = "Canada/Eastern";
  };

  # Manages keys and such
  programs = {
    # Needed for anything GTK related
    dconf.enable = true;

    # My shell
    # fish executed in bash if it is interactive shell
    # bash = {
    #   enable = true;
    #   interactiveShellInit = ''
    #     if [[ $(${pkgs.procps}/bin/ps -o ucomm | grep fish | sort | uniq) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
    #     then
    #       shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
    #       exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
    #     fi
    #   '';
    # };

    # ssh = {
    #   startAgent = true;
    # };

    nix-ld = {
      enable = true;
    };

    fish = {
      enable = true;
    };

    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };

  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "ghostty";
  };

  environment.sessionVariables = {
    XCURSOR_THEME = "macOS";
    XCURSOR_SIZE = "24";
    HYPRCURSOR_THEME = "macOS";
    HYPRCURSOR_SIZE = "24";
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __GL_GSYNC_ALLOWED = "";
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    GDK_SCALW = "2";

    NIKPKGS_ALLOW_UNFREE = "1";

    EDITOR = "nvim";

    # ANTHROPIC_API_KEY = ''$(${pkgs.coreutils}/bin/cat ${config.age.secrets."api-Claude".path})'';
    # OPENAI_API_KEY = ''$(${pkgs.coreutils}/bin/cat ${config.age.secrets."api-OpenAI".path})'';
  };

  system.stateVersion = "24.11"; # Don't change this
}
