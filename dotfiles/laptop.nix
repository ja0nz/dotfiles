{ config, pkgs, ... }:

{
  imports = [
    /home/jan/nixconf/dotfiles/common.nix
    /etc/nixos/hardware-configuration.nix
    /etc/nixos/cachix.nix
  ];

  config = {
#    boot.initrd.luks.devices = {
#      cryptlvm = {
#        device = "/dev/sda2";
#        allowDiscards = true;
#        preLVM = true;
#      };
#   };

    machine = "laptop";

    networking.hostName = "jan_nixos"; # Define your hostname.

    hardware = {
      cpu.intel.updateMicrocode = true;
    };

    services = {
      upower.enable = true;

      tlp.enable = true;
      logind.lidSwitch = "ignore";
    };
  };
}
