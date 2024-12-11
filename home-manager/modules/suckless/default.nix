{ config, lib, pkgs, dwl-source, dwlb-source, slstatus-source, ... }:

let
  suckless-overlay = [

    (final: prev: {
      dwl = (prev.callPackage ./dwl/package.nix { }).overrideAttrs (oldAttrs: rec {
        src = dwl-source;
      });
    })
    
    (final: prev: {
      dwlb = (prev.callPackage ./dwlb/package.nix { }).overrideAttrs (oldAttrs: rec {
        src = dwlb-source;
      });
    })
    
    (final: prev: {
      slstatus = (prev.callPackage ./slstatus/package.nix { }).overrideAttrs (oldAttrs: rec {
        src = slstatus-source;
      });
    })
    
  ];
in {
  nixpkgs.overlays = suckless-overlay ;

  home.packages = [
    pkgs.dwl
    pkgs.dwlb
    pkgs.slstatus
  ];
}
