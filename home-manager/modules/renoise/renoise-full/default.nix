{ pkgs, lib, renoise-src, ... }:

{
  home.packages = with pkgs; [
    ((pkgs.callPackage ./package.nix {})
      .override( { releasePath = renoise-src; } )
    )
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "renoise"
  ];
  
}
