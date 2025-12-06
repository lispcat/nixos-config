{ pkgs, user, ... }:

{

  ### Virtualization ################################################

  virtualisation.libvirtd = {
    enable = true;
    qemu.package = pkgs.qemu_kvm;
  };
  users.users.${user}.extraGroups = [ "libvirtd" ];

  ### Flatpak #######################################################

  # services.flatpak.enable = true;
  # systemd.services.flatpak-repo = {
  #   wantedBy = [ "multi-user.target" ];
  #   path = [ pkgs.flatpak ];
  #   script = ''
  #     flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  #   '';
  # };

  ### Portals #######################################################

  # (disabled bc now using hyprland portals)

  # xdg.portal = {
  #   enable = true;
  #   wlr.enable = true;
  #   # configPackages = with pkgs; [ xdg-desktop-portal-wlr ];
  #   configPackages = with pkgs; [ xdg-desktop-portal-gtk ];
  #   extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  # };

  # enable configuring gtk themes in home-manager
  programs.dconf.enable = true;

}
