{
  boot = {
    # disable webcam
    blacklistedKernelModules = [
      "uvcvideo"
    ];
    
    # Bootloader (TODO: move to hardware-configuration ?)
    loader.grub = {
      enable = true;
      device = "/dev/sda";
      useOSProber = true;
    };
  };
}
