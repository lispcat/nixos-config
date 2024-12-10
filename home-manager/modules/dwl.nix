{ config, pkgs, dwl-source, ... }:

{
  # nixpkgs.overlays = [
  #   (self: super: {
  #     dwl = super.callPackage ./pkgs/dwl-v07.nix { } .overrideAttrs (oldAttrs: {
  #       src = inputs.dwl-source;
  #     });
  #   })
  # ];
  nixpkgs.overlays = [
    (final: prev: {
      dwl = prev.dwl.overrideAttrs (oldAttrs: rec {
        src = dwl-source;
      });
    })
  ];

}
