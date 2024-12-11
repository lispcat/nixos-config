{ pkgs, ... }:

{
  boot = {
    kernel.sysctl = { "vm.swappiness" = 1; };

    tmp.clearOnBoot = true;
    
    # disable webcam
    blacklistedKernelModules = [ "uvcvideo" ];

    loader.grub = {
      enable = true;
      useOSProber = true;
      # device = <add in hardware configuration>
    };
  };
  
}
