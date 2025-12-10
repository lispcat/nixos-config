{ config, pkgs, lib, mkFeature, ... }:

let
  files = [
    ./wlr-which-key
  ];
  imported-configs = lib.map
    (path: import path { inherit lib config pkgs; })
    files;
in {
  imports = [
    (mkFeature "dotfiles" "Tangle all dotfiles" (
      lib.mkMerge imported-configs
    ))
  ];
}
