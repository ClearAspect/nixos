{
  pkgs,
  config,
  ...
}: {
  # Terms
  ".config/kitty".source = ../../files/kitty;

  # ".tmux.conf".source = ./config/.tmux.conf;
  # ".tmux".source = ./.tmux;

  # ".config/yazi".source = ./yazi;
  # ".config/bat".source = ./bat;
  # ".config/fastfetch".source = ./fastfetch;
  # ".ssh".source = ./.ssh;
}
