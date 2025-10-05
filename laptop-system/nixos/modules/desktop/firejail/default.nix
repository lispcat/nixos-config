{ ... }:

{
  programs.firejail.enable = true;

  imports = [
    ./games.nix
    ./proprietary.nix
    ./music.nix
  ];
}
