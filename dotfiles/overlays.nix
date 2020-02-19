let
  waylandOverlay = import (builtins.fetchTarball {
    url = https://github.com/colemickens/nixpkgs-wayland/archive/master.tar.gz;
  });
in
{
  antOverlay = self: super: {
    inherit (import /home/alex/nixpkgs2 { })
    ant-theme ant-dracula-theme ant-nebula-theme ant-bloody-theme;
  };

  emacsOverlay = import (builtins.fetchTarball {
    url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
  });

  myWaylandOverlay = waylandOverlay;# self: super: {
  #   inherit (waylandOverlay {} super) redshift-wayland wldash;
  # };

  nixmacsOverlay = self: super: {
    nixmacs = (self.pkgs.callPackage (/home/alex/nixmacs) {
      configurationFile = /home/alex/dotfiles/nixmacsConf.nix;
    });
  };

  cattOverlay = self: super: {
    catt = (self.pkgs.callPackage ./pkgs/catt { });
  };

  agdaOverlay = self: super: {
    haskellPackages = super.haskellPackages.override {
      overrides = new: old: {
        Agda = ((self.haskellPackages.override {
          overrides = new: old: {
            regex-tdfa = new.regex-tdfa_1_3_1_0;
          };
        }).callPackage ./pkgs/agda { });
      };
    };
  };
}
