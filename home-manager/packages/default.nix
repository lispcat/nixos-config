{ pkgs, ... }:

{
  imports = [
    ./suckless
    ./renoise
  ];

  # regular packages
  home.packages = with pkgs; [
    tree
    acpi
  ];
}
