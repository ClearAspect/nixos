{
  config,
  pkgs,
  ...
}: {
  tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      catppuccin
      {
        plugin = resurrect; # Used by tmux-continuum

        # Use XDG data directory
        # https://github.com/tmux-plugins/tmux-resurrect/issues/348
        extraConfig = ''
          set -g @resurrect-dir '$HOME/.cache/tmux/resurrect'
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-pane-contents-area 'visible'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '5' # minutes
        '';
      }
    ];
    prefix = "C-a";
    escapeTime = 0;
    historyLimit = 50000;
    extraConfig = "
		unbind r
		bind r source-file ~/.tmux.conf; display-message \"Config reloaded\"


		set -g base-index 1              # start indexing windows at 1 instead of 0
		set -g escape-time 0             # zero-out escape time delay
		set -g renumber-windows on       # renumber all windows when any window is closed
		set -g set-clipboard on          # use system clipboard
		set -g status-position top
		set -g default-terminal \"$TERM\"
		setw -g mode-keys vi
		set -g mouse on

		unbind %
		bind | split-window -h
		unbind '\"'
		bind - split-window -v

		bind -r j resize-pane -D 5
		bind -r k resize-pane -U 5
		bind -r h resize-pane -L 5
		bind -r l resize-pane -R 5
		bind -r m resize-pane -Z

		bind-key -T copy-mode-vi v send-keys -X begin-selection
		bind-key -T copy-mode-vi y send-keys -X copy-selection
		unbind -T copy-mode-vi MouseDragEnd1Pane



		set -g @plugin 'catppuccin/tmux#latest'

		set -g @resurrect-capture-pane-contents 'on'
		set -g @continuum-restore 'on'

		set -g @catppuccin_flavour 'mocha'
		set -g @catppuccin_window_number_position 'right'
		set -g @catppuccin_window_left_separator ' '
		set -g @catppuccin_window_right_separator ''
		set -g @catppuccin_window_middle_separator ' █'
		";
  };
}
