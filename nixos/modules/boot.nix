{
  boot = {
    kernel.sysctl = { "vm.swappiness" = 1; };
    
    # disable webcam
    blacklistedKernelModules = [
      "uvcvideo"
    ];
    
    # fix AX200 wifi issue
    kernelModules = [ "iwlwifi" ];
    extraModprobeConfig = ''
      options iwlwifi power_save=0
      options iwlmvm power_scheme=1
    '';
    
    # Bootloader (TODO: move to hardware-configuration ?)
    loader.grub = {
      enable = true;
      device = "/dev/sda";
      useOSProber = true;
    };
    
  };

  # services.btrfs = {
  #   autoScrub.enable = true;
  # };
  
  # services.fstrim = {
  #   enable = true;
  # };
}
