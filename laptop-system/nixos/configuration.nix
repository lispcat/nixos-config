# For manual: configuration.nix(5) and `nixos-help'

{ config, pkgs, ... }:

{
  imports = [
    ./hardware/system76
    ./modules

    ./packages.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];  # enable flakes

  system.stateVersion = "24.05"; # don't touch

}
