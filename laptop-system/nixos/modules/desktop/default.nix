{ ... }:

{
  imports = [
    ./apps.nix
    ./dev.nix
    ./wayland.nix

    ./firejail
    ./music
  ];
}
