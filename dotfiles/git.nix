{ ... }:

{
  programs.git = {
    enable = true;
    userName = "ja0nz";
    userEmail = "mail@ja.nz";
    ignores = ["*~"];
    signing = {
      key = "3A83233C"; # Short key: gpg --list-secret-keys --keyid-format short
      signByDefault = true;
    };
    extraConfig = {
      core.filemode = false;
      pull.rebase = true;
    };
  };
}
