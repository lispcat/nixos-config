{ ... }:

{
  programs.firejail.enable = true;
  
  imports = [
    ./foss.nix
    ./games.nix
    ./proprietary.nix
    ./music.nix
  ];
}
