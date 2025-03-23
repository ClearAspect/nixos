{
  config,
  pkgs,
  ...
}: {
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
}
