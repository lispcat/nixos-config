{ pkgs, lib, ... }:

{
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
    configPackages = with pkgs; [ xdg-desktop-portal-gtk ];
  };
  # TODO: is this good?
  # xdg.portal = {
  #   enable = true;
  #   lxqt.enable = true;
  #   extraPortals = [ pkgs.xdg-desktop-portal-kde ];
  #   config = {
  #     common = {
  #       default = [ "kde" ];
  #     };
  #   };
  # };

  # environment.systemPackages = with pkgs;[
  #   adw-gtk3
  # ];

  # enable configuring gtk themes in home-manager
  programs.dconf.enable = true;
  # programs.dconf = {
  #   enable = true;
  #   profiles.user.databases = [{
  #     settings = with lib.gvariant; {
  #       "org/gnome/desktop/interface" = {
  #         color-scheme = "prefer-dark";
  #         gtk-theme = "adw-gtk3-dark";
  #       };
  #     };
  #   }];
  # };

  services.dbus.enable = true;
  # services.gvfs.enable = true;
}
