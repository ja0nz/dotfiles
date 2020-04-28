{ config, pkgs, ... }:

let
  inherit (config) scripts;
in
{
  programs.fish = {
    enable = true;
    shellAliases = {
      groups = "id (whoami)";
      node = "env NODE_NO_READLINE=1 rlwrap node";
      bw-user = "${scripts}/bw-get.fish username";
      bw-pw = "${scripts}/bw-get.fish password";
      nix-stray-roots = "nix-store --gc --print-roots | egrep -v '^(/nix/var|/run/\w+-system|\{memory)'";
    };
    promptInit = "
    any-nix-shell fish --info-right | source
    ";
  };

  home.sessionVariables = {
    EDITOR = "emacsclient -c";
    BROWSER = "qutebrowser";
  };

  xdg.configFile."fish/functions".source = pkgs.callPackage ./fish_prompt.nix { };
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = [ "qutebrowser.desktop" "firefox.desktop"];
      "x-scheme-handler/http" = [ "qutebrowser.desktop" "firefox.desktop" ];
      "x-scheme-handler/https" = [ "qutebrowser.desktop" "firefox.desktop" ];
      "x-scheme-handler/ftp" = [ "qutebrowser.desktop" "firefox.desktop" ];
      "x-scheme-handler/chrome" = [ "qutebrower.desktop" "firefox.desktop" ];
      "x-scheme-handler/org-protocol" = [ "org-protocol.desktop" ];
    };
  };
}
