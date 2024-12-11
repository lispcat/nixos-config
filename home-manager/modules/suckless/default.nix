{ config, pkgs, dwl-source, dwlb-source, slstatus-source, ... }:

# nixpkgs.overlays = [
#   (self: super: {
#     dwl = super.callPackage ./pkgs/dwl-v07.nix { } .overrideAttrs (oldAttrs: {
#       src = inputs.dwl-source;
#     });
#   })
# ];

let
  suckless-overlays = [
    (final: prev: {
      dwl = (prev.callPackage ./dwl/package.nix { }).overrideAttrs (oldAttrs: {
        src = dwl-source;
      });
    });
    (final: prev: {
      dwlb = (prev.callPackage ./dwlb/package.nix { }).overrideAttrs (oldAttrs: {
        src = dwlb-source;
      });
    });
    (final: prev: {
      slstatus = (prev.callPackage ./slstatus/package.nix { }).overrideAttrs (oldAttrs: {
        src = slstatus-source;
      });
    });
  ];
in {
  nixpkgs.overlays = suckless-overlays;
}
