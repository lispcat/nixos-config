{ pkgs, lib, user, ... }:

let
  renoise-src = "/home/${user}/opt/rns/rns_344_linux_x86_64.tar.gz";
  renoise-nix = ./renoise-344.nix;

  def-pkgs = {
    home.packages = with pkgs; [
      rubberband  # check if the second attr set overwrites rubberband & mpg123
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
      
      nixpkgs.allowUnfreePackage = [
        "renoise"
      ];
    }
    else {};
  
  result = def-pkgs // renoise-pkg;
  
in result
  
