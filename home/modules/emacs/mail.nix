{ config, pkgs, ... }: {
  programs.mbsync = {
    enable = true;
  };

  services.mbsync = {
    enable = true;
    preExec = "${config.xdg.configHome}/mbsync/preExec";
    postExec = "${config.xdg.configHome}/mbsync/postExec";
    verbose = true;
  };

  programs.msmtp = {
    enable = true;
  };

  programs.notmuch = {
    enable = true;
    # Can't find from PATH
    # hooks = {
    #   preNew = "mbsync -Va";
    # };
    hooks = {
      postNew = ''
        # immediately archive all messages from "me"
        notmuch tag -new -- tag:new and from:ian@ianpark.dev

        # delete all messages from a spammer:
        # notmuch tag +deleted -- tag:new and from:spam@spam.com

        # tag all message from notmuch mailing list
        # notmuch tag +notmuch -- tag:new and to:notmuch@notmuchmail.org

        # Tag all jobs
        notmuch tag +jobs -- from:glassdoor.com OR from:linkedin.com OR from:ziprecruiter.com OR from:indeed.com OR from:nexxt.com OR from:angel.co OR from:emailjobdelivery.com OR from:jobs2web.com OR from:careers.ext.hp.com OR from:careers.ibm.com OR from:neuvoo.com OR from:cisco.avature.net OR from:topresume.com OR from:amazon.jobs OR from:fastapplyjobs.com OR from:getitllc.com OR from:getcoboljobs.com OR from:usajobsdirectory.com OR from:monster.com OR from:myworkday.com OR from:optnation.org OR from:noreply+jobs@google.com OR from:yearup.org OR from:talent@careers.ext.hp.com OR from:careerbuilder.com OR from:tailoredopportunities.com OR from:dice.com OR from:myrocketcareer.com OR from:zbitt.com

        # Tag all repos
        notmuch tag +repos -- tag:new and noreply@github.com bugzilla-daemon@mozilla.org

        # Tag all emacs-devel mailing list
        notmuch tag +emacsdevel -- tag:new and from:emacs-devel@gnu.org OR to:emacs-devel@gnu.org

        # Tag all emacs-org-mode mailing list
        notmuch tag +orgmode -- tag:new and from:emacs-orgmode@gnu.org OR to:emacs-orgmode@gnu.org

        # Tag all emacs-devel mailing list
        notmuch tag +drops -- tag:new and from:drop.com

        # Tag all from notmuch mailing list
        notmuch tag +notmuch -- to:notmuch@notmuchmail.org

        # Tag all from social websites
        notmuch tag +social -- from:notifications-noreply@linkedin.com OR messages-noreply@linkedin.com OR invitations@linkedin.com OR messaging-digest-noreply@linkedin.com OR no-reply@mail.instagram.com OR notifications@discordapp.com OR noreply@discordapp.com OR no-reply@accounts.google.com OR noreply@google.com

        # Tag all from food websites
        notmuch tag +food -- from:blazinrewards@emailinfo.buffalowildwings.com

        # Tag all from course websites
        notmuch tag +courses from:yourfriends@interviewcake.com OR no-reply@m.mail.coursera.org OR Coursera@email.coursera.org OR receipts+VU5YDh5kQrAIpFKPy8nu@stripe.com

        # Tag all from mailing lists
        notmuch tag +mailinglists -- tag:emacsdevel OR tag:notmuch OR tag:orgmode

        # finally, retag all "new" messages "inbox" and "unread"
        notmuch tag +inbox +unread -new -- tag:new
      '';
    };
  };

  accounts.email = {
    maildirBasePath = ".mail";
    accounts."fastmail" = {
      primary = true;
      address = "ian@ianpark.dev";
      userName = "ian@ianpark.dev";
      passwordCommand = "${pkgs.pass}/bin/pass mail/fastmail.com/app-password";
      imap.host = "imap.fastmail.com";
      imap.port = 993;
      smtp.host = "smtp.fastmail.com";
      smtp.port = 587;

      mbsync = {
        enable = true;
        create = "both";
        expunge = "both";
        flatten = ".";
        patterns = ["*" "![Fastmail]*" "[Fastmail]/Sent Mail" "[Fastmail]/Starred" "[Fastmail]/All Mail"];
        extraConfig = {
          channel = {
            Sync = "All";
          };
          account = {
            Timeout = 120;
            PipelineDepth = 1;
          };
        };
      };

      msmtp = {
        enable = true;
      };

      notmuch = {
        enable = true;
      };

      realName = "Ian Park";
      signature = {
        text = ''
          Ian Park
        '';
        showSignature = "append";
      };
    };
  };

  xdg.configFile."mbsync/preExec" = {
    text = ''
    #!${pkgs.stdenv.shell}
    # ${pkgs.libnotify}/bin/notify-send -t 5000 "Syncing mails 📫️"

    export NOTMUCH_CONFIG=${config.xdg.configHome}/notmuch/notmuchrc
    export NMBGIT=${config.xdg.dataHome}/notmuch/nmbug
    '';
    executable = true;
  };

  xdg.configFile."mbsync/postExec" = {
    text = ''
    #!${pkgs.stdenv.shell}
    export NOTMUCH_CONFIG=${config.xdg.configHome}/notmuch/notmuchrc
    export NMBGIT=${config.xdg.dataHome}/notmuch/nmbug
    ${pkgs.notmuch}/bin/notmuch new

    # ${pkgs.libnotify}/bin/notify-send -t 5000 "Mails synced 📬"
    '';
    executable = true;
  };

  home.file.".local/share/bin/msync" = {
    text = ''
    #!${pkgs.stdenv.shell}
    systemctl --user start mbsync
    ${config.xdg.configHome}/mbsync/postExec
    '';
    executable = true;
  };
}
