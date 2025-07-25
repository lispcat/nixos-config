{ lib, ... }:

{
  # polkit (dont really know what this does)
  security.polkit.enable = true;

  # some programs depend on it i think
  services.dbus.enable = true;

  services = {
    # mounting disks
    udisks2.enable = true;
  };

  boot = {
    tmp.cleanOnBoot = true;
    kernel.sysctl = { "vm.swappiness" = lib.mkForce 1; };
    blacklistedKernelModules = [ "uvcvideo" ]; # disables webcam
  };
}
