{ ... }:

{
  imports = [
    ./firejail

    ./dev.nix
    ./portals.nix
    ./virtualization.nix
    ./wayland.nix
  ];
}
