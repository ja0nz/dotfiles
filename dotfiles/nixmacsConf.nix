{ config, lib, epkgs, ... }:

{
  layers = {
    ivy.enable = true;
    completion.enable = true;
    nix.enable = true;
    latex.enable = true;
    git.enable = true;
    c.enable = true;
    org.enable = true;
    python.enable = true;
    javascript.enable = true;
    systemd.enable = true;
  };

  settings.debug.enable = true;

  package.smartparens = {
    enable = true;
  };

  package.neo-theme.settings.neo-theme = "arrow";

  package.nix-update.enable = true;

  package.direnv.enable = true;

  package.which-key.enable = true;

  package.xah-fly-keys = {
    enable = true;
    settings.keyboard-layout = "dvorak";
    use-package.chords."nh" = "xah-fly-command-mode-activate";
  };

  package.use-package-chords.use-package.custom.key-chord-two-keys-delay = 0.2;

  appearance = {
    theme = {
      enable = true;
      package = epkgs.melpaPackages.dracula-theme;
      themeName = "dracula";
    };
    fonts = {
      font = "Source Code Pro 11";
      unicode-font = "STIXGeneral";
    };
  };
}
