{ pkgs, ... }:

{
  services = {
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd 'dwl -s \"dwlb\"'";
        };
      };
    };
    # mounting disks
    udisks2.enable = true;
  };

  # TODO: is this good?
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    lxqt.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-kde ];
    config = {
      common = {
        default = [ "kde" ];
      };
    };
  };
}
