{ pkgs, inputs, ... }:

let
  din-is-noise   = pkgs.callPackage ./din-is-noise { withJack = true; };
  renoise-custom = pkgs.callPackage ./renoise { inherit inputs; };
in
{
  environment.systemPackages = with pkgs; [
    # custom
    renoise-custom
    din-is-noise

    # synths
    bespokesynth
    surge-XT
    zynaddsubfx
    geonkick
    vcv-rack
    dexed
    ams
    bristol

    # daws
    reaper

    # tools
    mpg123
    rubberband
  ];

  nixpkgs.allowUnfreePackages = [
    "renoise"
    "reaper"
    "vcv-rack"
  ];
}
