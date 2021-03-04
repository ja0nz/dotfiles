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
      rg = "rg --hidden --glob '!.git'";
      cat = "bat";
      nix-stray-roots = "nix-store --gc --print-roots | egrep -v '^(/nix/var|/run/\w+-system|\{memory)'";
    };
    promptInit = "
    any-nix-shell fish --info-right | source
    ";

    plugins = [
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
          sha256 =  "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
        };
      }
    ];
  };

  home.sessionVariables = {
    EDITOR = "emacsclient -c";
    BROWSER = "qutebrower";
    PATH = "$HOME/.yarn/bin:$HOME/git/git-fuzzy/bin:$PATH"; # Impure but harmless!
  };

  xdg.configFile."fish/functions".source = pkgs.callPackage ./fish_prompt.nix { };
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [ "okular.desktop" ];
      "text/html" = [ "chromium.desktop" ];
      "image/png" = [ "eom.desktop " ];
      "image/jpeg" = [ "eom.desktop" ];
      "x-scheme-handler/org-protocol" = [ "org-protocol.desktop" ];
    };
  };
}
