{...}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    defaultKeymap = "emacs";
    shellAliases = {
      # git
      gaa = "git add --all";
      gcam = "git commit --all --message";
      gcl = "git clone";
      gco = "git checkout";
      ggl = "git pull";
      ggp = "git push";

      # kubectl
      # k = "kubectl";
      # kgno = "kubectl get node";
      # kdno = "kubectl describe node";
      # kgp = "kubectl get pods";
      # kep = "kubectl edit pods";
      # kdp = "kubectl describe pods";
      # kdelp = "kubectl delete pods";
      # kgs = "kubectl get svc";
      # kes = "kubectl edit svc";
      # kds = "kubectl describe svc";
      # kdels = "kubectl delete svc";
      # kgi = "kubectl get ingress";
      # kei = "kubectl edit ingress";
      # kdi = "kubectl describe ingress";
      # kdeli = "kubectl delete ingress";
      # kgns = "kubectl get namespaces";
      # kens = "kubectl edit namespace";
      # kdns = "kubectl describe namespace";
      # kdelns = "kubectl delete namespace";
      # kgd = "kubectl get deployment";
      # ked = "kubectl edit deployment";
      # kdd = "kubectl describe deployment";
      # kdeld = "kubectl delete deployment";
      # kgsec = "kubectl get secret";
      # kdsec = "kubectl describe secret";
      # kdelsec = "kubectl delete secret";

      ld = "lazydocker";
      lg = "lazygit";

      repo = "cd $HOME/Documents/repositories";
      temp = "cd $HOME/Downloads/temp";

      v = "nvim";
      vi = "nvim";
      vim = "nvim";
      vimdiff = "nvim -d";

      ls = "eza --icons always"; # default view
      ll = "eza -bhl --icons --group-directories-first"; # long list
      la = "eza -abhl --icons --group-directories-first"; # all list
      lt = "eza --tree --level=2 --icons"; # tree
    };
    initExtra = ''
      # kubectl auto-complete
      # source <(kubectl completion zsh)
      # zstyle ':completion:*' menu select

      # Zsh reverse auto-completion
      zmodload zsh/complist
      bindkey '^[[Z' reverse-menu-complete
      # To get new binaries into PATH
      zstyle ':completion:*' rehash true
      autoload -U select-word-style
      select-word-style bash

      
      #zstyle ':completion:*' file-sort modification
      zstyle ':completion:*' file-sort date
      zstyle ':completion:*' menu yes=long select
      zstyle ':completion:*' matcher-list ''\'''\' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

      # Disable prompt disappearing on multi-lines
      export COMPLETION_WAITING_DOTS="false"
      export EDITOR=nvim

      # zstyle ':completion:*:default' list-colors ''${(s.:.)LS_COLORS} "ma=48;5;244;38;5;255"

      # bindings
      bindkey '^A' beginning-of-line
      bindkey '^E' end-of-line
      bindkey '^H' backward-delete-word
      # bindkey '^[[1;5C' forward-word
      # bindkey '^[[1;5D' backward-word

      # open commands in $EDITOR with C-e
      # autoload -z edit-command-line
      # zle -N edit-command-line
      # bindkey "^e" edit-command-line
      autoload colors # color array builder
      autoload run-help # help function
      autoload zcalc # calculator
      autoload zsh/terminfo # interface to terminfo database

    '';
  };

  programs.readline = {
    enable = true;
    includeSystemConfig = true;

    bindings = {
      "\\t" = "menu-complete";
      "\\e[Z" = "menu-complete-backward";
      "\\e[A" = "history-search-backward";
      "\\e[B" = "history-search-forward";
    };

    variables = {
      show-all-if-ambiguous = true;
      show-all-if-unmodified = true;
      menu-complete-display-prefix = true;
      match-hidden-files = false;
      completion-query-items = 0;
      completion-ignore-case = true;
      page-completions = false;
      colored-stats = true;
      expand-tilde = true;
    };
  };



  # Starship configuration
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      directory = {
        style = "bold lavender";
      };
      aws = {
        disabled = true;
      };
      docker_context = {
        symbol = " ";
      };
      golang = {
        symbol = " ";
      };
      kubernetes = {
        disabled = false;
        style = "bold pink";
        symbol = "󱃾 ";
        format = "[$symbol$context( \($namespace\))]($style)";
        contexts = [
          {
            context_pattern = "arn:aws:eks:(?P<var_region>.*):(?P<var_account>[0-9]{12}):cluster/(?P<var_cluster>.*)";
            context_alias = "$var_cluster";
          }
        ];
      };
      lua = {
        symbol = " ";
      };
      package = {
        symbol = " ";
      };
      php = {
        symbol = " ";
      };
      python = {
        symbol = " ";
      };
      terraform = {
        symbol = " ";
      };
      right_format = "$kubernetes";
    };
  };
}
