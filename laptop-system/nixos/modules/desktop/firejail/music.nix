{ pkgs, ... }:

{
  nixpkgs.allowUnfreePackages = [
    "vital"
  ];

  environment.systemPackages = with pkgs; [
    vital
  ];
}
