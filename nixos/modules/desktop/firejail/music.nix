{ pkgs, lib, ... }:

{
  nixpkgs.allowUnfreePackages = [
    "vital"
  ];

  environment.systemPackages = with pkgs; [
    vital
  ];
}
