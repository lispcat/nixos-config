{ pkgs, lib, ... }:

let
  tar-src = "/home/sui/opt/renoise/rns_343_linux_x86_64.tar.gz";
in {
  
  if ! builtins.pathExists tar-src then
    null
  else {
    
    home.packages = with pkgs; [
      ((pkgs.renoise
        .override( { releasePath = tar-src; } ))
      )];
    
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "renoise"
    ];
    
  };
}
