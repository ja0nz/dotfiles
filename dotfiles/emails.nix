{ config, ... }:
let
  inherit (config) dots;
in
{
  accounts.email.accounts = {
    "jan@peteler.email" = rec {
      primary = true;
      address = "jan@peteler.email";
      userName = address;
      realName = "Jan Peteler";
      passwordCommand = "gpg2 -q --for-your-eyes-only --no-tty -d ${dots}/protected/mbsyncpass.gpg";
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
      passwordCommand = "gpg2 -q --for-your-eyes-only --no-tty -d ${dots}/protected/mbsyncpass.gpg";
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
