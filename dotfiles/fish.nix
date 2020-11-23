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
      bws = "${scripts}/bw-session.fish";
      ls = "exa";
      cat = "bat";
      nix-stray-roots = "nix-store --gc --print-roots | egrep -v '^(/nix/var|/run/\w+-system|\{memory)'";
    };
    promptInit = "
    any-nix-shell fish --info-right | source
    ";
  };

  home.sessionVariables = {
    EDITOR = "emacsclient -c";
    BROWSER = "qutebrower";
    PATH = "/home/jan/.yarn/bin:$PATH";
  };

  xdg.configFile."fish/functions".source = pkgs.callPackage ./fish_prompt.nix { };
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [ "okular.desktop" ];
      "text/html" = [ "qutebrowser.desktop" ];
      "x-scheme-handler/http" = [ "qutebrowser.desktop" ];
      "x-scheme-handler/https" = [ "qutebrowser.desktop" ];
      "x-scheme-handler/ftp" = [ "qutebrowser.desktop" ];
      "x-scheme-handler/chrome" = [ "qutebrower.desktop" ];
      "x-scheme-handler/org-protocol" = [ "org-protocol.desktop" ];
    };
  };
}
