{ config, pkgs, lib, ... }:

with lib;

let
  inherit (import /home/jan/nixconf/dotfiles/overlays.nix) waylandOverlay;
in
{
  options = {
    machine = mkOption {
      type = types.enum [
        "laptop"
        "desktop"
      ];
    };
  };

  imports =
    [
      ./home.nix
      ./users.nix
    ];

  config = {
    nixpkgs.overlays = [
      myWaylandOverlay
    ];

    nixpkgs.config = {
      allowUnfree = true;
    };

#    boot.supportedFilesystems = [ "ntfs" ];

    security.sudo.enable = true;
    security.sudo.extraConfig = "Defaults pwfeedback";
    programs.sway = {
      enable = true;
      extraSessionCommands = ''
        export _JAVA_AWT_WM_NONREPARENTING=1
        export XDG_CURRENT_DESKTOP=sway
        export XDG_SESSION_TYPE=wayland
        systemctl --user import-environment
      '';
    };

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.consoleMode = "max";
    boot.loader.efi.canTouchEfiVariables = true;
    # boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.networkmanager = {
    enable = true;
    # wifi.backend = "iwd";
    };

    # Select internationalisation properties.
    console = {
      font = "Lat2-Terminus16";
      keyMap = "neo";
    };

    i18n = {
      defaultLocale = "en_US.UTF-8";
    };

    hardware = {
      pulseaudio = {
        enable = true;
        support32Bit = true;
        extraModules = [ pkgs.pulseaudio-modules-bt ];
        package = pkgs.pulseaudioFull;
      };
      bluetooth = {
        enable = true;
        package = pkgs.bluezFull;
      };
      opengl.enable = true;
      opengl.driSupport32Bit = true;
      brillo.enable = true;
    };

    # Set your time zone.
    time.timeZone = "Europe/Berlin";

    nix = {
      package = pkgs.nixUnstable;
      extraOptions = ''
        keep-outputs = true
        experimental-features = nix-command flakes
      '';
      autoOptimiseStore = true;
      trustedUsers = ["@wheel"];
    };

    # System packages
    environment = {
      systemPackages = with pkgs; [
        git
        bup
#        xboxdrv
      ];
    };

    # Load fonts
    fonts = {
      fonts = with pkgs; [
        source-code-pro
        powerline-fonts
        symbola
        dejavu_fonts
        emacs-all-the-icons-fonts
        noto-fonts
        # nerdfonts
        fira-code
      ];

      fontconfig = {
        enable = true;
        antialias = true;
        cache32Bit = true;
        defaultFonts = {
          monospace = [ "Source Code Pro" "DejaVu Sans Mono" ];
          sansSerif = [  "DejaVu Sans" ];
          serif = [  "DejaVu Serif" ];
        };
      };
    };

    services = {
      mingetty.autologinUser = "jan";

      geoclue2.enable = true;

      xserver = {
        enable = true;
        desktopManager.plasma5.enable = true;
        displayManager.startx.enable = true;
      };
    };

    # xdg.portal = {
    #   enable = true;
    #   extraPortals = with pkgs; [
    #     xdg-desktop-portal-wlr
    #   ];
    # };

#    services.gvfs.enable = true;

    programs.dconf.enable = true;
#    programs.adb.enable = true;

    # Enable sound.
    sound.enable = true;

    programs.fish = {
      enable = true;
       loginShellInit = ''
         if not set -q SWAYSTARTED
           if not set -q DISPLAY && test (tty) = /dev/tty1
             set -g SWAYSTARTED 1
             exec sway
           end
         end
       '';
    };

    virtualisation.libvirtd = {
      enable = true;
      allowedBridges = [ "virbr0" ];
    };

    # Set up immutable users
    users = {
      mutableUsers = false;
      users.root = {
        shell = pkgs.fish;
        hashedPassword = "$6$9IUNqyGsWrU$Pfhv8Smj6YURO60E8JRu96DbBhzvXMTcSV4sADJpLurOljurJf4H3DqpYTklBYeQxQxOE7n5DFmTPpqsiRczZ.";
      };
      users.jan = {
        shell = pkgs.fish;
        isNormalUser = true;
        home = "/home/jan";
        extraGroups = ["wheel" "networkmanager" "video" "audio" "libvirtd"];
        uid = 1000;
        hashedPassword = "$6$CBDCAMFsC$GnF91Mr6dee0qO6mxJwGwXIEfnixNP/d80KB38mf2mIz9c4HuoGwNY2i1UERhkdj.QwTgZy5CodMc3kMi.wCf/";
      };
    };

    fileSystems."/home/jan" = {
      device = "/dev/disk/by-label/HOME";
      options = ["rw" "noatime"];
      encrypted = {
       enable = true;
       blkDev = "/dev/sda5";
       label = "home";
      };
    };

    # This value determines the NixOS release with which your system is to be
    # compatible, in order to avoid breaking some software such as database
    # servers. You should change this only after NixOS release notes say you
    # should.
    system.stateVersion = "18.09"; # Did you read the comment?
  };
}
