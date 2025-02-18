{pkgs}: let
  languages = import ./languages.nix {
    inherit pkgs;
  };
in
  with pkgs;
    [
      # Core System Utilities
      coreutils
      killall
      wget
      tree
      fd
      ripgrep
      fzf

      # Archive Management
      zip
      unzip
      unrar

      # Development Tools
      neovim
      helix
      lazygit
      tree-sitter
      tmux

      # System Monitoring & Management
      btop
      openssh
      pass

      # Shell Enhancements
      zoxide
      oh-my-posh
      # zsh-autosuggestions
      # zsh-syntax-highlighting

      # File Management & Navigation
      yazi
      lsd

      # System Information
      fastfetch

      # Fonts & Theming
      cozette
      commit-mono
      font-awesome
      (pkgs.nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
    ]
    ++ languages
