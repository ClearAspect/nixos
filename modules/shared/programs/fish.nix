{
  config,
  pkgs,
  ...
}: {
  fish = {
    enable = true;
    shellAliases = {
      cd = "z";
      ls = "lsd --color=auto";
      grep = "grep --color=auto";
      vi = "nvim";
      vim = "nvim";
    };
    # interactiveShellInit = ''
    #   if test -n "$GHOSTTY_RESOURCES_DIR"
    #       source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
    #   end
    # '';
    shellInit = ''
      export GPG_TTY=$(tty)
    '';
    plugins = [
      {
        name = "nix-env";
        src = pkgs.fetchFromGitHub {
          owner = "lilyball";
          repo = "nix-env.fish";
          rev = "master";
          sha256 = "sha256-RG/0rfhgq6aEKNZ0XwIqOaZ6K5S4+/Y5EEMnIdtfPhk=";
        };
      }
      {
        name = "fish_logo";
        src = pkgs.fetchFromGitHub {
          owner = "laughedelic";
          repo = "fish_logo";
          rev = "master";
          sha256 = "sha256-DZXQt0fa5LdbJ4vPZFyJf5FWB46Dbk58adpHqbiUmyY=";
        };
      }
    ];
  };
}
