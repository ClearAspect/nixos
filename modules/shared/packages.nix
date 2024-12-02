{pkgs}:
with pkgs; [
  # kitty

  # General packages for development and system management
  btop
  coreutils
  fastfetch
  lazygit
  lsd
  neovim
  openssh
  oh-my-posh
  killall
  yazi
  wget
  zip
  zoxide
  # zsh-autosuggestions
  # zsh-syntax-highlighting

  # Fonts
  cozette
  commit-mono

  # llvm
  # llvm_18
  # gcc
  lua
  python3
  cargo
  cmake
  jdk
  maven
  zigpkgs.master

  # Media-related packages
  font-awesome

  # Node.js development tools
  nodePackages.npm # globally install npm
  nodePackages.prettier
  nodejs

  # Text and terminal utilities
  pass
  coreutils
  btop
  fzf
  killall
  ripgrep
  tree
  tree-sitter
  tmux
  unrar
  unzip
  wget
  zip

  # Formatter
  alejandra
]
