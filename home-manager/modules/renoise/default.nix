{ pkgs, lib, ... }:

let
  renoise-src = "/home/sui/opt/renoise/rns_344_linux_x86_64.tar.gz";
  renoise-nix = ./renoise-344.nix;

  def-pkgs = {
    home.packages = with pkgs; [
      rubberband
      mpg123
    ];
  };

  renoise-pkg =
    if builtins.pathExists renoise-src
    then {
      home.packages = with pkgs; [
        ((pkgs.callPackage renoise-nix {})
          .override( { releasePath = renoise-src; } ))
      ];
      
      nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "renoise"
      ];
    }
    else {};
  
  result = def-pkgs // renoise-pkg;
  
in result
  
