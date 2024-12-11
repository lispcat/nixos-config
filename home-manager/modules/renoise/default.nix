{ pkgs, ... }:

let
  my-renoise =
    ((pkgs.renoise
      .override( { releasePath = "/home/sui/opt/renoise/rns_343_linux_x86_64.tar.gz"; } ))
    );
in {
  
  home.packages = with pkgs; {
    my-renoise
  };
  
}
