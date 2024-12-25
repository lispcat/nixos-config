{ ... }:

{
  programs.firejail.enable = true;
  
  imports = [
    ./renoise
    
    ./foss.nix
    ./games.nix
    ./proprietary.nix
  ];
}
