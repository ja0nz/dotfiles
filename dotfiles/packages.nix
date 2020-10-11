

{ pkgs, ... }:

let
  cabal-bin = pkgs.callPackage (import ./pkgs/agda-2.6.2.nix) { };
in
{
  home.packages = with pkgs; [

    wldash
    nixmacs
    wl-clipboard
    cachix
    catt
    pinentry
    binutils
    my-zoom
    styx

    # CLI Programs
    neofetch
    tree
    wget
    gnupg
    curl
    psmisc
    gparted
    mkpasswd
    file
    binutils
    imagemagick
    unzip
    zip
    pdftk
    pamixer
    lgogdownloader
    fzf
    htop
    iftop
    gitAndTools.git-extras

    # Things in sway config
    j4-dmenu-desktop
    bemenu
    dropbox-cli
    networkmanager_dmenu
    networkmanagerapplet
    dmenu

    # Nix
    nixpkgs-fmt
    nix-review
    nix-info
    nix-index
    direnv

    # GTK
    hicolor-icon-theme

    # Dictionaries
    aspell
    aspellDicts.en

    # Wayland
    mako
    grim
    slurp
    waybar
    swaylock

    # Utilities
    blueman
    pavucontrol
    udiskie
    playerctl
    xlibs.xeyes
    veracrypt
    libnotify
    libappindicator
    bitwarden-cli
    xdg_utils

    # Desktop environment
    (mate.caja-with-extensions.override { extensions = [ mate.caja-extensions mate.caja-dropbox ]; })
    mate.eom
    glib

    # LaTeX
    texlive.combined.scheme-full

    # Programming
    (haskellPackages.ghcWithHoogle
    (haskellPackages: with haskellPackages; [
      lens
      arrows
      process
      containers
      parsec
      multimap
      quickcheck-with-counterexamples
      cassava
      diagrams
      ieee
      filemanip
    ]))
    (agda.withPackages (p: [ p.standard-library p.agda-categories p.cubical ]))
    # cabal-bin
    cabal-install
    cabal2nix
    python3
    coqPackages_8_12.coq

    # Programs
    emacs
    firefox
    chromium
    thunderbird
    vlc
    gimp
    evince
    spotify
    libreoffice
    discord
    zathura
    mu

    # Games
    steam
    sgtpuzzles
    dwarf-fortress-packages.dwarf-fortress-full
    # steam-run-native
    # wine
    # winetricks
  ];
}
