{ config, ... }:

let
  inherit (config) dots;
in
{
  programs.ssh = {
    enable = true;
    hashKnownHosts = true;
    matchBlocks = {
      "peteler.family" = {
        host = "pf";
        hostname = "peteler.family";
        user = "root";
        identitiesOnly = true;
        identityFile = "${dots}/protected/ssh/id_peteler.family_ed25519";
      };
      "git.peteler.family" = {
        user = "git";
        identitiesOnly = true;
        identityFile = "${dots}/protected/ssh/id_git.peteler.family_ed25519";
        port = 2222;
        checkHostIP = false;
      };
      "github.com" = {
        user = "git";
        identitiesOnly = true;
        identityFile = "${dots}/protected/ssh/id_github_ed25519";
        checkHostIP = false;
      };
    };
  };
}
