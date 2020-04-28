{ config, ... }:

let
  inherit (config) dots;
in
{
#  home.file.".ghc/ghci.conf".source = "${dots}/ghci.conf";
  home.file.".config/waybar/config".source = "${dots}/waybar";
  home.file.".config/waybar/style.css".source = "${dots}/waybar.css";
#  home.file.".agda/defaults".text = ''
#    standard-library
#  '';
  home.file.".config/qutebrowser/autoconfig.yml".source = "${dots}/pkgs/qutebrowser/autoconfig.yml";
  home.file.".authinfo.gpg".source = "${dots}/protected/authinfo.gpg";
#### Emacs - needs some cleanup #####
  home.file.".emacs.d/prelude-pinned-packages.el".source = "${dots}/pkgs/emacs/prelude-pinned-packages.el";
  home.file.".emacs.d/personal/custom-keybindings.el".source = "${dots}/pkgs/emacs/personal/custom-keybindings.el";
  home.file.".emacs.d/personal/mail.el".source = "${dots}/pkgs/emacs/personal/mail.el";
  home.file.".emacs.d/personal/misc.el".source = "${dots}/pkgs/emacs/personal/misc.el";
  home.file.".emacs.d/personal/nim.el".source = "${dots}/pkgs/emacs/personal/nim.el";
  home.file.".emacs.d/personal/org-mode.el".source = "${dots}/pkgs/emacs/personal/org-mode.el";
  home.file.".emacs.d/personal/prelude-modules.el".source = "${dots}/pkgs/emacs/personal/prelude-modules.el";
  home.file.".emacs.d/personal/setup-ligatures.el".source = "${dots}/pkgs/emacs/personal/setup-ligatures.el";
}
