{ config, lib, pkgs, ... }:

with lib;

{
  imports = [ <home-manager/nixos> ];

  home-manager.users.jan = {pkgs, lib, ...}:
  {
    imports = [
      ./packages.nix
      ./alacritty.nix
      ./files.nix
      ./git.nix
      ./gtk.nix
      ./direnv.nix
      ./fish.nix
      ./gammastep.nix
      ./systemd.nix
      ./sway.nix
      ./emails.nix
      ./lorri.nix
      ./gpg.nix
      ./ssh.nix
      ./udiskie.nix
      ./blueman.nix
    ];

    options = {
      dots = mkOption {
        type = types.path;
      };
      scripts = mkOption {
        type = types.path;
      };
      modifier = mkOption {
        type = types.str;
      };
      machine = mkOption {
        type = types.enum [
          "laptop"
          "desktop"
          "rpi"
        ];
      };
    };

    config = {
      _module.args.setEnvironment = config.system.build.setEnvironment;

      nixpkgs.config = {
        allowBroken = true;
        allowUnfree = true;
        allowUnsupportedSystem = true;
        oraclejdk.accept_license = true;
      };

      nixpkgs.overlays = builtins.attrValues (import ./overlays.nix);

      dots = /home/jan/nixconf/dotfiles;
      scripts = /home/jan/nixconf/scripts;
      modifier = "Mod4";
      machine = config.machine;
    };
  };
}
