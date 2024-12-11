# For manual: configuration.nix(5) and `nixos-help'

{ config, pkgs, ... }:

{
  imports = [
    ./hardware # dir
    ./modules  # dir
    ./packages.nix
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

  # don't touch
  system.stateVersion = "24.05";

}
