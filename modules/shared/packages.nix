{pkgs}: let
  languages = import ./languages.nix {
    inherit pkgs;
  };
in
  with pkgs;
    [
      # ┏━━━━━━━━━━━━━━━━━━━━┓
      # ┃   Core Utilities   ┃
      # ┗━━━━━━━━━━━━━━━━━━━━┛
      coreutils
      killall
      wget
      tree
      fd
      ripgrep
      fzf

      # ┏━━━━━━━━━━━━━━━━━━━━━━━━┓
      # ┃   Archive Management   ┃
      # ┗━━━━━━━━━━━━━━━━━━━━━━━━┛
      zip
      unzip
      unrar

      # ┏━━━━━━━━━━━━━━━━━━━━━━━┓
      # ┃   Development Tools   ┃
      # ┗━━━━━━━━━━━━━━━━━━━━━━━┛
      neovim
      helix
      lazygit
      tree-sitter
      tmux
      asciinema

      # ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
      # ┃   System Monitoring & Mgmt   ┃
      # ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
      btop
      openssh

      # ┏━━━━━━━━━━━━━━━━━━━━━━━━┓
      # ┃   Shell Enhancements   ┃
      # ┗━━━━━━━━━━━━━━━━━━━━━━━━┛
      zoxide
      oh-my-posh
      # zsh-autosuggestions
      # zsh-syntax-highlighting

      # ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
      # ┃   File Management & Nav   ┃
      # ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
      yazi
      lsd

      # ┏━━━━━━━━━━━━━━━━━━━━━━━━┓
      # ┃   System Information   ┃
      # ┗━━━━━━━━━━━━━━━━━━━━━━━━┛
      fastfetch

      # ┏━━━━━━━━━━━━━━━━━━━━━┓
      # ┃   Fonts & Theming   ┃
      # ┗━━━━━━━━━━━━━━━━━━━━━┛
      cozette
      commit-mono
      font-awesome
      nerd-fonts.fira-code
      nerd-fonts.symbols-only
      jetbrains-mono

      # ┏━━━━━━━━━━━━━━┓
      # ┃   Security   ┃
      # ┗━━━━━━━━━━━━━━┛
      gnupg
      pass
      yubikey-manager
      yubikey-personalization
      pcsc-tools
      pinentry-curses
    ]
    ++ languages
