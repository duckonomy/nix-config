{...}: {
  programs = {
    eza = {
      enable = true;
      enableZshIntegration = true;
    };

    atuin = {
      enable = true;
      settings = {
        inline_height = 25;
        invert = true;
        records = true;
        search_mode = "skim";
        secrets_filter = true;
        style = "compact";
      };
      flags = ["--disable-up-arrow"];
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    fd = {
      enable = true;
      extraOptions = [
        "--no-ignore"
        "--absolute-path"
      ];
      ignores = [
        ".git/"
        "*.bak"
      ];
    };

    ripgrep = {
      enable = true;
      arguments = [
        "--max-columns-preview"
        "--colors=line:style:bold"
      ];
    };

    # Install fzf via home-manager module
    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "fd .";
      defaultOptions = [
        "--bind '?:toggle-preview'"
        "--bind 'ctrl-a:select-all'"
        "--bind 'ctrl-e:execute(echo {+} | xargs -o nvim)'"
        "--bind 'ctrl-y:execute-silent(echo {+} | wl-copy)'"
        "--color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'"
        "--height=40%"
        "--info=inline"
        "--layout=reverse"
        "--multi"
        "--preview '([[ -f {}  ]] && (bat --color=always --style=numbers,changes {} || cat {})) || ([[ -d {}  ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'"
        "--preview-window=:hidden"
        "--prompt='~ ' --pointer='▶' --marker='✓'"
      ];
    };

    btop = {
      enable = true;
      settings = {
        vim_keys = true;
      };
    };

    bat = {
      enable = true;
    };
  };
}
