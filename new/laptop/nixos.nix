{ ... }:

{
  system.stateVersion = "24.05"; # don't touch

  imports = [
    ./hardware/system76
    ./packages.nix
    ./modules
  ];
}
