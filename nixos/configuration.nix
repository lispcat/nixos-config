# For manual: configuration.nix(5) and `nixos-help'

{ config, pkgs, ... }:

{
  imports = [
    ./hardware  # dir
    ./modules  # dir
    ./packages.nix
  ];

  disabledModules = [
    
  ];
  

  # general

  services.xserver.xkb = { # kblayout
    layout = "us";
    variant = "dvp";
    options = "ctrl:nocaps";
  };
  console = {
    useXkbConfig = true;
    earlySetup = true;  # for grub?
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ]; # enable flakes

  system.stateVersion = "24.05"; # don't touch

}
