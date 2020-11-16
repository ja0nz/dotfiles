{ config, pkgs, lib, ... }:

with lib;

let inherit (import /home/jan/nixconf/dotfiles/overlays.nix) waylandOverlay;
in {
  options = {
    machine = mkOption { type = types.enum [ "laptop" "desktop" ]; };
  };

  imports = [ ./home.nix ./users.nix ];

  config = {
    nixpkgs.overlays = [ waylandOverlay ];

    nixpkgs.config = { allowUnfree = true; };

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
    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.firewall = {
      allowedUDPPorts = [
        51820 # wireguard
      ];
      #allowedTCPPorts = [
      #  22 # ssh
      #];
    };

    networking.networkmanager = {
      enable = true;
      unmanaged = [ "interface-name:wg*" ];
     # dispatcherScripts = [{
     #   source = pkgs.writeScript "up-fix-wireguard" ''
     #     #!/bin/sh
     #     case $2 in
     #       up)
     #         wg-quick up wg0
     #         ip route add 188.214.158.10 via $IP4_GATEWAY
     #         ;;
     #       pre-down)
     #         wg-quick down wg0
     #         ;;
     #     esac
     #   '';
     # }];
      # wifi.backend = "iwd";
    };

    # Select internationalisation properties.
    console = {
      font = "Lat2-Terminus16";
      keyMap = "neo";
    };

    i18n = { defaultLocale = "en_US.UTF-8"; };

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
      # temporary revert to nixStable
      package = pkgs.nixStable;
      extraOptions = ''
                keep-outputs = true
        #        experimental-features = nix-command flakes
              '';
      autoOptimiseStore = true;
      trustedUsers = [ "@wheel" ];
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
          sansSerif = [ "DejaVu Sans" ];
          serif = [ "DejaVu Serif" ];
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

    fileSystems."/home/jan" = {
      device = "/dev/disk/by-label/HOME";
      options = [ "rw" "noatime" ];
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
