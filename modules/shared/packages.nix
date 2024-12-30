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
  helix
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

  # Languages and Support
  # C
  # llvm
  # llvm_18
  # gcc
  clang-tools
  cmake

  # Java
  openjdk
  maven
  jdt-language-server

  # Python
  python3
  ruff

  # Nix
  nixd
  alejandra

  # Other
  lua
  cargo
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
  fd
  tree
  tree-sitter
  tmux
  unrar
  unzip
  wget
  zip
]
