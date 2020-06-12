{ config, ... }:

{
  accounts.email.accounts = {
    "jan@peteler.email" = rec {
      primary = true;
      address = "jan@peteler.email";
      userName = address;
      realName = "Jan Peteler";
      #passwordCommand = "gpg2 -q --for-your-eyes-only --no-tty -d ${config.dots}/protected/mbsyncpass.gpg";
      passwordCommand = "${config.scripts}/bw-session.fish get password 0a6a82ff-3b42-4581-b8d9-27efd064b41b";
      mbsync = {
        enable = true;
        create = "maildir";
        expunge = "both";
        extraConfig.account.AuthMechs = "Plain";
      };
      imap = {
        host = "imap.purelymail.com";
        tls.enable = true;
      };
#      notmuch.enable = true;
    };

    "mail@ja.nz" = rec {
      address = "mail@ja.nz";
      userName = address;
      realName = "Ja0nz";
      #passwordCommand = "gpg2 -q --for-your-eyes-only --no-tty -d ${config.dots}/protected/mbsyncpass.gpg";
      passwordCommand = "${config.scripts}/bw-session.fish get password 662527a5-ed17-4144-8668-7814571c40c7";
      mbsync = {
        enable = true;
        create = "maildir";
        expunge = "both";
        extraConfig.account.AuthMechs = "Plain";
      };
      imap = {
        host = "imap.purelymail.com";
        tls.enable = true;
      };
#      notmuch.enable = true;
    };
  };

  programs.mbsync.enable = true;
#  programs.notmuch.enable = true;
}
