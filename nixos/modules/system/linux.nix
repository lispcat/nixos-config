{ ... }:

{
  # polkit (useful)
  security.polkit.enable = true;

  services = {
    # mounting disks
    udisks2.enable = true;
  };
  
  boot = {
    tmp.cleanOnBoot = true;
    kernel.sysctl = { "vm.swappiness" = 1; };
    blacklistedKernelModules = [ "uvcvideo" ]; # disables webcam
  };
}
