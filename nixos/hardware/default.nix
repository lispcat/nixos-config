{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    # ./qemu-1.nix
    ./system76.nix
  ];
}
