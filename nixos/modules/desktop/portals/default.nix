{ pkgs, lib, ... }:

{
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    configPackages = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  # enable configuring gtk themes in home-manager
  programs.dconf.enable = true;

}
