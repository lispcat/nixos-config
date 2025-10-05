# For manual: configuration.nix(5) and `nixos-help'

{ ... }:

{
  # flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # don't touch
  system.stateVersion = "24.05"; # don't touch

  # modules
  imports = [
    ./hardware/system76
    ./packages.nix
    ./modules
  ];
}
