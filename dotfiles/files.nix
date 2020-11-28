{ config, ... }:

let
  inherit (config) dots;
in
{
#  home.file.".ghc/ghci.conf".source = "${dots}/ghci.conf";
  home.file.".config/waybar/config".source = "${dots}/waybar";
  home.file.".config/waybar/style.css".source = "${dots}/waybar.css";
  home.file.".authinfo.gpg".source = "${dots}/protected/authinfo.gpg";
#  home.sessionPath = [ "~/.cabal/bin" ];
}
