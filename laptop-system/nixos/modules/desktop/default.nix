{ ... }:

{
  imports = [
    ./dev.nix
    ./flatpak.nix
    ./portals.nix
    ./virtualization.nix
    ./wayland.nix

    ./firejail
    ./music
  ];
}
