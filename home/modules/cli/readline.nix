{...}: {
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
}
