{
  pkgs,
  config,
  ...
}: {
  # ".tmux.conf".source = ./config/.tmux.conf;
  # ".tmux".source = ./.tmux;

  ".config/kitty".source = ./config/kitty;
  ".config/ghostty".source = ./config/ghostty;
  # ".config/yazi".source = ./yazi;
  # ".config/bat".source = ./bat;
  # ".config/fastfetch".source = ./fastfetch;
  # ".ssh".source = ./.ssh;
}
