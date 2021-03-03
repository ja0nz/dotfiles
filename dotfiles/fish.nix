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
        name = "fasd";
        src = pkgs.fetchFromGitHub {
        owner = "fishgretel";
        repo = "fasd";
        rev = "2c15e162c584312002c375a133fef7773ec33362";
        sha256 = "1hk10jymdnf2fv1pvql4kbhrxbd6kd5kfsd1dagn3rr55177lqmc";
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
