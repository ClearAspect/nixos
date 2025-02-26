{
  config,
  pkgs,
  lib,
  ...
}: let
  name = "ClearAspect";
  user = "roanm";
  email = "roanmason@live.ca";
in {
  # Shared shell configuration

  fish = {
    enable = true;
    # catppuccin.enable = true;
    shellAliases = {
      cd = "z ";
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

  # nushell = {
  #   enable = true;
  #   configFile = {
  #     text = ''
  #       let fish_completer = {|spans|
  #       fish --command $'complete "--do-complete=($spans | str join " ")"'
  #       | from tsv --flexible --noheaders --no-infer
  #       | rename value description
  #       }
  #
  #       $env.config.filesize_metric = false
  #       $env.config.table_mode = 'rounded'
  #       $env.config.use_ls_colors = true
  #     '';
  #   };
  # };

  oh-my-posh = {
    enable = true;
    settings = builtins.fromJSON (builtins.unsafeDiscardStringContext (builtins.readFile ./config/oh-my-posh/omp.json));
  };

  zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  zsh = {
    enable = false;
    autocd = false;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    completionInit = "
  if type brew &>/dev/null
  then
  fpath+=\"$(brew --prefix)/share/zsh/site-functions\"
  autoload -Uz compinit
  compinit
  fi

  zstyle ':completion:*' completer _list _expand _complete _ignored _correct _approximate
  zstyle ':completion:*' format '%F{black}-- %d --%f'
  zstyle ':completion:*' group-name ''
  zstyle ':completion:*' list-colors ''
  zstyle ':completion:*' menu select=2
  zstyle :compinstall filename '/home/roanm/.zshrc'

  autoload -Uz compinit
  compinit
  ";
    initExtraFirst = ''
      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi

      # Define variables for directories
      export PATH=$HOME/.pnpm-packages/bin:$HOME/.pnpm-packages:$PATH
      export PATH=$HOME/.npm-packages/bin:$HOME/bin:$PATH
      export PATH=$HOME/.local/share/bin:$PATH

      # Remove history data we don't want to see
      export HISTIGNORE="pwd:ls:cd"

    '';
  };

  fzf.enable = true;

  bat = {
    enable = true;
    # catppuccin.enable = true;
    config = {
      theme = "OneHalfDark";
    };
  };

  git = {
    enable = true;
    # ignores = ["*.swp"];
    userName = name;
    userEmail = email;
    lfs.enable = true;

    extraConfig = {
      init.defaultBranch = "master";
      core = {
        editor = "nvim";
        # autocrlf = "input";
      };
      # credential.credentialStore = "gpg";
      # credential.helper = "manager";
    };
  };

  ssh = {
    enable = true;
    includes = [
      (
        lib.mkIf pkgs.stdenv.hostPlatform.isLinux
        "/home/${user}/.ssh/config_external"
      )
      (
        lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
        "/Users/${user}/.ssh/config_external"
      )
    ];
    extraConfig = ''
      Host localhomeserver
      	HostName 192.168.10.208
      	User super
      	Port 22

      Host remotehomeserver
      	HostName 99.226.10.150
      	User super
      	Port 22

      Host roanmDesktop
      	HostName 192.168.10.248
      	User roanm
      	Port 22
      	ForwardAgent yes

      Host Roans-MacBook-Pro
      	HostName 192.168.10.223
      	user roanm
      	ForwardAgent yes


      VisualHostKey=yes
    '';
  };

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
