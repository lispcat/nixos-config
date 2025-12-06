{ ... }:

{
  programs.firejail.enable = true;

  imports = [
    ./profiles.nix
  ];
}
