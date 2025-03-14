{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./dock.nix
  ];

  # System Configurations
  system = {
    stateVersion = 5;

    checks.verifyNixPath = false;

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

  programs.fish = {
    enable = true;
  };

  # Yubico YubiKey Security Key
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  security.pam.enableSudoTouchIdAuth = true;

  environment.variables = {
    # ANTHROPIC_API_KEY = ''$(${pkgs.coreutils}/bin/cat ${config.age.secrets."api-Claude".path})'';
    # OPENAI_API_KEY = ''$(${pkgs.coreutils}/bin/cat ${config.age.secrets."api-OpenAI".path})'';
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
    {path = "/Applications/Ghostty.app/";}
  ];
}
