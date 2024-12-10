{ config, pkgs, dwl-source, ... }:

{
  # nixpkgs.overlays = [
  #   (self: super: {
  #     dwl = super.callPackage ./pkgs/dwl-v07.nix { } .overrideAttrs (oldAttrs: {
  #       src = inputs.dwl-source;
  #     });
  #   })
  # ];

  let

    dwl-overlay = self: super: {
      dwl = super.dwl.overrideAttrs (oldAttrs: {
        src = dwl-source;
      });
    };

  in {

    nixpkgs.overlays = [
      
      dwl-overlay
      
    ];
    
  };

}
