{ pkgs, lib, ... }:

let
  renoise-src = "/home/sui/opt/renoise/rns_343_linux_x86_64.tar.gz";
  renoise-nix = ./renoise-v344.nix;
  
  result = 
    if builtins.pathExists renoise-src
    then {
      home.packages = with pkgs; [
        
        # renoise-full
        ((pkgs.callPackage renoise-nix {})
          .override( { releasePath = renoise-src; } ))
        
        rubberband
        mpg123
      ];
      
      nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "renoise"
      ];
    }
    else {};
  
in result
  
