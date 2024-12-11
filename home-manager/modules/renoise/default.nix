{ pkgs, lib, renoise-src, ... }:

let
  renoise-src = "/home/sui/opt/renoise/rns_343_linux_x86_64.tar.gz";
  result = 
    if builtins.pathExists renoise-src
    then import ./renoise-full { inherit renoise-src; }
    else {};
in result
