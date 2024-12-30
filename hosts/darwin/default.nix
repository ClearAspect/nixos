{
  agenix,
  config,
  pkgs,
  lib,
  ...
}: let
  user = "roanm";
in {
  imports = [
    ../../modules/darwin/secrets.nix
    ../../modules/shared
    ../../modules/darwin/dock/default.nix
  ];

  # Users / Me
  users = {
    users.${user} = {
      name = "${user}";
      home = "/Users/${user}";
      isHidden = false;
      shell = pkgs.fish;
    };
  };

  # My shell
  # fish executed in bash if it is interactive shell
  # programs.bash = {
  #   enable = true;
  #   interactiveShellInit = ''
  #     if [[ $(${pkgs.procps}/bin/ps -o ucomm | grep fish | sort | uniq) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
  #     then
  #       shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
  #       exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
  #     fi
  #   '';
  # };
  programs.fish = {
    enable = true;
  };

  homebrew = {
    enable = true;
    casks = pkgs.callPackage ../../modules/darwin/casks.nix {};
    # onActivation.cleanup = "uninstall";

    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #
    # If you have previously added these apps to your Mac App Store profile (but not installed them on this system),
    # you may receive an error message "Redownload Unavailable with This Apple ID".
    # This message is safe to ignore. (https://github.com/dustinlyons/nixos-config/issues/83)
    # masApps = {
    #   "1password" = 1333542190;
    #   "wireguard" = 1451685025;
    # };
  };

  services.nix-daemon.enable = true;

  nix = {
    package = pkgs.nix;
    settings = {
      trusted-users = ["@admin" "${user}"];
      substituters = ["https://nix-community.cachix.org" "https://cache.nixos.org"];
      trusted-public-keys = ["cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="];
    };

    gc = {
      user = "root";
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 2;
        Minute = 0;
      };
      options = "--delete-older-than 30d";
    };

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  system.checks.verifyNixPath = false;

  # Yubico YubiKey Security Key
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  security.pam.enableSudoTouchIdAuth = true;

  environment.variables = {
    # Hack: https://github.com/ghostty-org/ghostty/discussions/2832
    # GHOSTTY_SHELL_INTEGRATION_XDG_DIR = "/Applications/Ghostty.app/Contents/Resources/shell-integration";
    XDG_DATA_DIRS = ["$GHOSTTY_SHELL_INTEGRATION_XDG_DIR"];
  };

  environment.systemPackages = with pkgs; [
    agenix.packages."${pkgs.system}".default
  ];

  system = {
    stateVersion = 4;

    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;

        KeyRepeat = 2; # Values: 120, 90, 60, 30, 12, 6, 2
        InitialKeyRepeat = 25; # Values: 120, 94, 68, 35, 25, 15

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;
      };

      dock = {
        autohide = true;
        show-recents = false;
        launchanim = true;
        orientation = "bottom";
        tilesize = 48;
      };

      finder = {
        _FXShowPosixPathInTitle = false;
      };

      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };
    };
  };

  # Fully declarative dock using the latest from Nix Store
  local.dock.enable = true;
  local.dock.entries = [
    {path = "/System/Applications/Launchpad.app/";}
    {path = "/Applications/Safari.app/";}
    {path = "/System/Applications/Messages.app/";}
    {path = "/System/Applications/Mail.app/";}
    {path = "/System/Applications/Photos.app/";}
    {path = "/System/Applications/Facetime.app/";}
    {path = "/System/Applications/Calendar.app/";}
    {path = "/System/Applications/Contacts.app/";}
    {path = "/System/Applications/Reminders.app/";}
    {path = "/System/Applications/Notes.app/";}
    {path = "/System/Applications/Music.app/";}
    {path = "/System/Applications/App Store.app/";}
    {path = "/System/Applications/System Settings.app/";}
    {path = "/Applications/Firefox.app/";}
    {path = "/Applications/Discord.app/";}
    # {path = "/Applications/Kitty.app/";}
    {path = "/Applications/Ghostty.app/";}
  ];
}
