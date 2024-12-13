{userConfig, ...}: {
  programs = {
  direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  git = {
    enable = true;
    userName = "${userConfig.fullName}";
    userEmail = "${userConfig.email}";
    # signing = {
    #   key = userConfig.gitKey;
    #   signByDefault = true;
    # };
    delta = {
      enable = true;
      options = {
        keep-plus-minus-markers = true;
        light = false;
        line-numbers = true;
        navigate = true;
        width = 280;
      };
    };
    extraConfig = {
      pull.rebase = "true";
    };
  };
};

}
