{pkgs, ...}: {
  programs.password-store = {
    enable = true;
  };

  programs.gpg = {
    enable = true;
    settings = {
      personal-cipher-preferences = "AES256";
      personal-digest-preferences = "SHA512";
      personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";
      default-preference-list = "SHA512 AES256 ZLIB BZIP2 ZIP Uncompressed";
      cert-digest-algo = "SHA512";
      s2k-digest-algo = "SHA512";
      s2k-cipher-algo = "AES256";
      charset = "utf-8";
      fixed-list-mode = true;
      no-comments = true;
      no-emit-version = true;
      no-greeting = true;
      keyid-format = "0xlong";
      list-options = "show-uid-validity";
      verify-options = "show-uid-validity";
      with-key-origin = true;
      require-cross-certification = true;
      no-symkey-cache = true;
      use-agent = true;
      throw-keyids = true;
    };
  };

    #  services.ssh-agent.enable
    # programs.ssh.enable
    # programs.ssh.addKeysToAgent
    # programs.ssh.extraConfig
    # programs.ssh.hashKnownHosts
    # programs.ssh.matchBlocks


  services.gpg-agent = {
    enable =
      if pkgs.stdenv.isDarwin
      then false
      else true;
    defaultCacheTtl = 86400;
    maxCacheTtl = 86400;
    defaultCacheTtlSsh = 86400;
    maxCacheTtlSsh = 86400;
    enableSshSupport = true;
    enableZshIntegration = true;
    pinentryPackage = pkgs.pinentry-curses;
    extraConfig = ''
      allow-emacs-pinentry
      allow-loopback-pinentry
    '';
  };
}
