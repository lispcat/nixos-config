{ config, pkgs, user, mkFeature, ... }:

{
  imports = [
    (mkFeature "virtualization" "Enables virtualization" {
      virtualisation.libvirtd = {
        enable = true;
        qemu.package = pkgs.qemu_kvm;
      };
      users.users.${user}.extraGroups = [ "libvirtd" ];
    })
    (mkFeature "flatpak" "Enables flatpak" {
      services.flatpak.enable = true;
      systemd.services.flatpak-repo = {
        wantedBy = [ "multi-user.target" ];
        path = [ pkgs.flatpak ];
        script = ''
          flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        '';
      };
    })
    (mkFeature "gtk-portal" "Enables the gtk xdg-portal (disable if using any other portal)" {
      xdg.portal = {
        enable = true;
        wlr.enable = true;      # wlroots support
        configPackages = with pkgs; [ xdg-desktop-portal-gtk ];
      };
      # enable configuring gtk themes in home-manager (i think)
      programs.dconf.enable = true;
    })
    (mkFeature "wlr-portal" "Enables the wlr xdg-portal (disable if using any other portal)" {
      xdg.portal = {
        enable = true;
        wlr.enable = true;      # wlroots support
        configPackages = with pkgs; [ xdg-desktop-portal-wlr ];
      };
      # enable configuring gtk themes in home-manager (i think)
      programs.dconf.enable = true;
    })
  ];

  config.assertions = [
    {
      assertion = !(
        config.features."gtk-portal".enable &&
        config.features."wlr-portal".enable &&
        config.features."hyprland".enable
      );
      message = ''
        Can only enable one portal at a time.
      '';
    }
  ];
}
