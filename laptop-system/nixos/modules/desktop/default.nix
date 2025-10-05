{ ... }:

{
  imports = [
    ./dev.nix
    ./flatpak.nix
    ./portals.nix

    ./firejail
    ./music
    ./virtualization
    ./wayland
  ];
}
