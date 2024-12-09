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

      v = "vim";
      vi = "vim";
      vim = "vim";

      ls = "eza --icons always"; # default view
      ll = "eza -bhl --icons --group-directories-first"; # long list
      la = "eza -abhl --icons --group-directories-first"; # all list
      lt = "eza --tree --level=2 --icons"; # tree
    };
    initExtra = ''
      # kubectl auto-complete
      # source <(kubectl completion zsh)

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
    '';
  };
}