# For manual: configuration.nix(5) and `nixos-help'

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ./modules
  ];

  # keyboard layout
  services.xserver.xkb = {
    layout = "us";
    variant = "dvp";
    options = "ctrl:nocaps";
  };
  console.useXkbConfig = true;

  # enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # dont touch
  system.stateVersion = "24.05";

}
