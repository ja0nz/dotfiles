{ pkgs, ... }:

let
#  cabal-bin = pkgs.callPackage (import ./pkgs/agda-2.6.2.nix) { };
  sizzy = import ./pkgs/sizzy;
  mymonero = import ./pkgs/mymonero;
in
{
  home.packages = with pkgs; [

    wldash
#    nixmacs
    wl-clipboard             # Command-line copy/paste utilities for Wayland
    cachix                   # Command line client for Nix binary cache hosting https://cachix.org
#    catt
    pinentry                 # GnuPG’s interface to passphrase input
    binutils                 # Tools for manipulating binaries (linker, assembler, etc.)
    # my-zoom                  # zoom.us video conferencing application
    # styx                     # Nix based static site generator
    # manix                    # A Fast Documentation Searcher for Nix

    # CLI Programs
#    neofetch                 # A fast, highly customizable system info script
    tree                     # Command to produce a depth indented directory listing
    wget                     # Tool for retrieving files using HTTP, HTTPS, and FTP
    gnupg                    # GNU Privacy Guard, a GPL OpenPGP implementation
    curl                     # A command line tool for transferring files with URL syntax
    psmisc                   # A set of small useful utilities that use the proc filesystem
    gparted                  # Graphical disk partitioning tool
#    mkpasswd                 # Overfeatured front-end to crypt, from the Debian whois package
    file                     # A program that shows the type of files
#    binutils
    imagemagick              # A software suite to create, edit, compose, or convert bitmap images
#    unzip                    # An extraction utility for archives compressed in .zip format
#    zip                      # Compressor/archiver for creating and modifying zipfiles
    pdftk                    # Simple tool for doing everyday things with PDF documents
    pamixer                  # Pulseaudio command line mixer
#    lgogdownloader           # Unofficial downloader to GOG.com for Linux users
    fzf                      # A command-line fuzzy finder written
    htop                     # An interactive process viewer for Linux
    iftop                    # Display bandwidth usage on a network interface
    gitAndTools.git-extras   # GIT utilities -- repo summary, repl, changelog population

    # Things in sway config
    dropbox-cli              # Command line client for the dropbox daemon
    networkmanager_dmenu     # Small script to manage NetworkManager connections with dmenu
    networkmanagerapplet     # NetworkManager control applet for GNOME
    dmenu                    # A generic, highly customizable, and efficient menu for the X Window System

    # Nix
    nixpkgs-fmt              # Nix code formatter for nixpkgs
#    nix-review
    nix-info                 #
    nix-index                # A files database for nixpkgs
    direnv                   # A shell extension that manages your environment

    # GTK
    hicolor-icon-theme       # Default fallback theme used by implementations of the icon theme specification

    # Dictionaries
    aspell                   # Spell checker for many languages
    aspellDicts.en           # Aspell dictionary for English

    # Wayland
    mako                     # A lightweight Wayland notification daemon
    grim                     # Grab images from a Wayland compositor
    slurp                    # Select a region in a Wayland compositor
    waybar                   # Highly customizable Wayland bar for Sway and Wlroots based compositors
    swaylock                 # Screen locker for Wayland

    # Utilities
    pavucontrol               # PulseAudio Volume Control
    udiskie                   # Removable disk automounter for udisks
    playerctl                 # Command-line utility for controlling media players that implement MPRIS
#    xlibs.xeyes
    libnotify                 # A library that sends desktop notifications to a notification daemon
#    libappindicator           # A library to allow applications to export a menu into the Unity Menu bar
    bitwarden-cli             # A secure and free password manager for all of your devices.
    xdg_utils                 # A set of command line tools that assist applications desktop integration

    # Desktop environment
    (mate.caja-with-extensions.override { extensions = [ mate.caja-extensions mate.caja-dropbox ]; })
    mate.eom                  # An image viewing and cataloging program for the MATE desktop
#    glib                      # C library of programming buildings blocks

    # LaTeX
#    texlive.combined.scheme-full

    # Programming
#    (haskellPackages.ghcWithHoogle
#    (haskellPackages: with haskellPackages; [
#      lens
#      containers
#      parsec
#      ieee
#      filemanip
#    ]))
#    (agda.withPackages (p: [ p.standard-library p.agda-categories p.cubical ]))
#    # cabal-bin
#    cabal-install
#    cabal2nix
    python3
#    coqPackages_8_12.coq

    # Programs
    emacs                     # The extensible, customizable GNU text editor
    firefox-bin               # A web browser built from Firefox source tree (with plugins: )
    chromium                  # An open web browser built from Firefox source tree (with plugins: )
#    thunderbird
    vlc                       # Cross-platform media player and streaming server
#    gimp
#    evince
#    spotify
#    libreoffice
#    discord
#    zathura
    mu                        # A collection of utilties for indexing and searching Maildirs

    # Games
#    steam
#    sgtpuzzles
#    steam-run-native
#    wine
#    winetricks

    ##### Added #####
    qutebrowser               # Keyboard-focused browser with a minimal GUI
    #mate.caja                 # File manager for the MATE desktop
    okular                    # KDE document viewer
    signal-desktop            # Private, simple, and secure messenger
    virtmanager               # Desktop user interface for managing virtual machines

    # Net
    (callPackage mymonero {}) # MyMonero Desktop Wallet
    mtr                       # A network diagnostics tool
    croc                      # Easily and securely send things from one computer to another
    httpie                    # A command line HTTP client whose goal is to make CLI human-friendly
    nmap                      # A free and open source utility for network discovery and security auditing
    tcpdump                   # Network sniffer
    gnutls                    # The GNU Transport Layer Security Library
    nomachine-client          # NoMachine Remote Desktop Client

    # Local
    #pstree                    # Show the set of running processes as a tree
    bat                       # A cat(1) clone with syntax highlighting and Git integration
    ripgrep                   # A utility that combines the usability of The Silver Searcher
    cryptsetup                # LUKS for dm-crypt
    exa                       # Replacement for 'ls' written in Rust
    calc                      # C-style arbitrary precision calculator
    unp                       # Command line tool for unpacking archives easily
    isync                     # Free IMAP and MailDir mailbox synchronizer
    parted                    # Create, destroy, resize, check, and copy partitions
    pandoc                    # Conversion betrween markup formats
    rlwrap                    # Readline wrapper for console programs
    any-nix-shell             # fish and zsh support for nix-shell
    graphviz                  # Graph visualization tools
    ditaa                     # Convert ascii art diagrams into proper bitmap graphics
    sqlite                    # A self-contained, serverless, zero-configuration SQL db engine
    jq                        # A lightweight and flexible command-line JSON processor
    git-secret                # A bash-tool to store your private data inside a git repository
    clipman                  # A simple clipboard manager for Wayland

    # Dev
    (callPackage sizzy {})    # The browser for Developers & Designers
    devd                      # A local webserver for developers
    nodejs_latest             # Event-driven I/O framework for the V8 JavaScript engine
    yarn                      # Fast, reliable, and secure dependency management for javascript
    guile                     # Embedded Scheme implementation
    racket                    # A programmable programming language
    gnumake                   # A tool to control the generation of non-source files from source
    nixfmt                    # An opinionated formatter for Nix
  ];
}
