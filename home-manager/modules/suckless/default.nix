{ config, pkgs, dwl-source, dwlb-source, slstatus-source, ... }:

let
  suckless-overlay = final: prev: {
    
    dwl = (prev.callPackage ./dwl/package.nix { }).overrideAttrs (oldAttrs: {
      src = dwl-source;
    });
    
    dwlb = (prev.callPackage ./dwlb/package.nix { }).overrideAttrs (oldAttrs: {
      src = dwlb-source;
    });
    
    slstatus = (prev.callPackage ./slstatus/package.nix { }).overrideAttrs (oldAttrs: {
      src = slstatus-source;
    });
    
  };
in {
  nixpkgs.overlays = [
    suckless-overlay
  ];
}
