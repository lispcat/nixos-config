{ pkgs, ... }:

let
  din-is-noise = import ./din-is-noise;
in
{
  imports = [
    ./renoise
    ./din-is-noise
  ];

  nixpkgs.allowUnfreePackages = [
    "reaper"
  ];

  environment.systemPackages = with pkgs; [
    reaper

    din-is-noise

  ];
}
