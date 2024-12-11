{ pkgs, lib, ... }:

let
  tar-src = "/home/sui/opt/renoise/rns_343_linux_x86_64.tar.gz";

  result =
    if builtins.pathExists tar-src then
      let
        my-renoise =
          ((pkgs.renoise
            .override( {releasePath = tar-src;} )))
      in {            
        home.packages = with pkgs; [
          
        ];
        
        nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
          "renoise"
        ];
      };
    else
      null;
in
result

