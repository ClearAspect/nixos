{
  config,
  pkgs,
  ...
}: let
  user = "roanm";
in {
  imports =
    [
      ./system.nix
      ./security.nix
      ./users.nix
      ./dock.nix
      ./packages.nix
      ./homebrew.nix
    ]
    ++ [(import ../../modules/shared)]
    ++ [(import ../../modules/darwin/secrets.nix)]
    ++ [(import ../../modules/darwin/dock/default.nix)];

  nix = {
    enable = true;
    package = pkgs.nix;
    settings = {
      trusted-users = ["@admin" "${user}"];
      substituters = ["https://nix-community.cachix.org" "https://cache.nixos.org"];
      trusted-public-keys = ["cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="];
    };

    gc = {
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

  environment.variables = {
    # Hack: https://github.com/ghostty-org/ghostty/discussions/2832
    # GHOSTTY_SHELL_INTEGRATION_XDG_DIR = "/Applications/Ghostty.app/Contents/Resources/shell-integration";
    XDG_DATA_DIRS = ["$GHOSTTY_SHELL_INTEGRATION_XDG_DIR"];

    # ANTHROPIC_API_KEY = ''$(${pkgs.coreutils}/bin/cat ${config.age.secrets."api-Claude".path})'';
    # OPENAI_API_KEY = ''$(${pkgs.coreutils}/bin/cat ${config.age.secrets."api-OpenAI".path})'';
  };
}
